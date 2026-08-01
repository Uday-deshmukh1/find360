-- Find360 - Supabase schema (free tier)
-- Run this whole file in Supabase > SQL Editor. Safe to re-run.

-- ===== 1. TABLES =====

create table if not exists public.users (
    id uuid primary key references auth.users(id) on delete cascade,
    name text default '',
    email text,
    profile_photo_url text default '',
    role text not null default 'user' check (role in ('user', 'admin', 'agent')),
    banned boolean not null default false,
    created_at timestamptz not null default now()
);

-- Banned flag on existing users (safe to re-run)
alter table public.users add column if not exists banned boolean not null default false;

create table if not exists public.properties (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    price bigint not null,
    location text not null,
    bhk text default '',
    description text default '',
    image_urls text[] default '{}',
    owner_id uuid references public.users(id) on delete set null,
    verified boolean default false,
    status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
    created_at timestamptz not null default now()
);

-- Approval status on existing properties (existing rows become 'pending')
alter table public.properties add column if not exists status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected'));

create table if not exists public.likes (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id) on delete cascade,
    property_id uuid not null references public.properties(id) on delete cascade,
    created_at timestamptz not null default now(),
    unique (user_id, property_id)
);

-- ===== 2. INDEXES =====

create index if not exists idx_properties_location on public.properties(location);
create index if not exists idx_properties_price on public.properties(price);
create index if not exists idx_properties_owner on public.properties(owner_id);
create index if not exists idx_properties_status on public.properties(status);
create index if not exists idx_likes_user on public.likes(user_id);
create index if not exists idx_likes_property on public.likes(property_id);

-- ===== 3. HELPERS (SECURITY DEFINER so RLS never blocks them) =====

create or replace function public.is_admin()
returns boolean language sql security definer stable as $$
    select exists (
        select 1 from public.users where id = auth.uid() and role = 'admin'
    );
$$;

create or replace function public.is_banned()
returns boolean language sql security definer stable as $$
    select coalesce((select banned from public.users where id = auth.uid()), false);
$$;

-- First person to sign up becomes admin; everyone after is a regular user.
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
    if (select count(*) from public.users) = 0 then
        new.role := 'admin';
    else
        new.role := 'user';
    end if;
    return new;
end;
$$;

drop trigger if exists trg_new_user_role on public.users;
create trigger trg_new_user_role
before insert on public.users
for each row execute function public.handle_new_user();

-- ===== 4. ROW LEVEL SECURITY =====

alter table public.users enable row level security;
alter table public.properties enable row level security;
alter table public.likes enable row level security;

-- USERS
drop policy if exists "Users can view own profile" on public.users;
create policy "Users can view own profile" on public.users
    for select using (auth.uid() = id or public.is_admin());

drop policy if exists "Only admins can update users" on public.users;
create policy "Only admins can update users" on public.users
    for update using (public.is_admin());

drop policy if exists "Enable insert for signup" on public.users;
create policy "Enable insert for signup" on public.users
    for insert with check (auth.uid() = id);

drop policy if exists "Only admins can delete users" on public.users;
create policy "Only admins can delete users" on public.users
    for delete using (public.is_admin());

-- PROPERTIES
-- Everyone can see approved listings; owners see their own; admins see everything.
drop policy if exists "Anyone can view properties" on public.properties;
drop policy if exists "Anyone can view approved properties" on public.properties;
create policy "Anyone can view approved properties" on public.properties
    for select using (status = 'approved' or auth.uid() = owner_id or public.is_admin());

-- Users can list their own property; banned users cannot.
drop policy if exists "Authenticated users can insert properties" on public.properties;
create policy "Users can list their own properties" on public.properties
    for insert with check (
        public.is_admin() or (auth.uid() = owner_id and not public.is_banned())
    );

drop policy if exists "Owners can update their properties" on public.properties;
create policy "Owners can update their properties" on public.properties
    for update using (
        public.is_admin() or (auth.uid() = owner_id and not public.is_banned())
    );

drop policy if exists "Owners can delete their properties" on public.properties;
create policy "Owners can delete their properties" on public.properties
    for delete using (
        public.is_admin() or (auth.uid() = owner_id and not public.is_banned())
    );

-- LIKES
drop policy if exists "Users can view own likes" on public.likes;
create policy "Users can view own likes" on public.likes
    for select using (auth.uid() = user_id or public.is_admin());

drop policy if exists "Users can add likes" on public.likes;
create policy "Users can add likes" on public.likes
    for insert with check (auth.uid() = user_id);

drop policy if exists "Users can remove likes" on public.likes;
create policy "Users can remove likes" on public.likes
    for delete using (auth.uid() = user_id);
