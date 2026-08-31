const CACHE_NAME = 'find360-v7';
const ASSETS = [
    '/',
    '/index.html',
    '/callback.html',
    '/app.html',
    '/admin.html',
    '/style.css',
    '/supabase-js.js',
    '/supabase-config.js?v=6',
    '/manifest.json',
    '/icon.svg'
];

self.addEventListener('install', (e) => {
    e.waitUntil(
        caches.open(CACHE_NAME).then(cache => cache.addAll(ASSETS))
    );
    self.skipWaiting();
});

self.addEventListener('activate', (e) => {
    e.waitUntil(
        caches.keys().then(keys =>
            Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))
        )
    );
    self.clients.claim();
});

self.addEventListener('fetch', (e) => {
    if (e.request.url.includes('supabase-config.js')) {
        e.respondWith(fetch(e.request).then(res => {
            const copy = res.clone();
            caches.open(CACHE_NAME).then(c => c.put(e.request, copy));
            return res;
        }).catch(() => caches.match(e.request)));
        return;
    }
    if (e.request.url.includes('supabase') || e.request.url.includes('googleapis') || e.request.url.includes('gstatic')) {
        e.respondWith(fetch(e.request).catch(() => caches.match(e.request)));
        return;
    }
    if (e.request.mode === 'navigate') {
        e.respondWith(fetch(e.request).then(res => {
            const copy = res.clone();
            caches.open(CACHE_NAME).then(c => c.put(e.request, copy));
            return res;
        }).catch(() => caches.match(e.request)));
        return;
    }
    e.respondWith(
        caches.match(e.request).then(cached => cached || fetch(e.request))
    );
});
