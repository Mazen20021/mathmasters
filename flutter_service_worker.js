'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "b3bc47de7a8375680ba3272baaa5bc12",
".git/config": "6e2ba475c60c2835264db2cd92e9efa4",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "cb636aeea8337aa041de4eb7b025d1ac",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "33620923967c860bb8df1bbc90973231",
".git/logs/refs/heads/main": "fc95a1d9ee14049383f4b616366e6b4c",
".git/logs/refs/remotes/origin/main": "73250d52a99b42a31650cd558e76b284",
".git/objects/04/7c9e269b5dbda09392671c1e027e751dd96f81": "ae0bc60806a621f97b41beedc1e62abf",
".git/objects/0f/8a2d944d542266c73d76a7c109c3ca7f06a3e4": "982203e54a9f0bb71396365913aac626",
".git/objects/0f/c344c7e8b9e32ea1ad91f30ded22556352d7bf": "a8a30f28869f7378465338066f34d80d",
".git/objects/11/ebe0abf0e894a859e0fb58e7eae195cda45183": "a448adc1da0456db701dc50d773d932a",
".git/objects/18/6026ab9a3ffca74ec40b9a141a0887e88f85a5": "055d1458cbce9cc78c1cbab3849220ac",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/18/f5050f5fefc69ebb1be7a25601756c3079631d": "dab756604b8a3c5d2f73b07bf910e367",
".git/objects/1b/f452b8e532ff1c8f0ef39d0e8bf64df4cef282": "a8ced7a0ecdfa59c513d5da1a3d70286",
".git/objects/1c/3789911f2a7156adccb37a502b34b2f1d2eb40": "a5b1936e4e4818afb7924933c617d348",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/20/6c98d96c9813f590baeecf4a8d13cfd971efad": "a92b4ff843466d67f4e2e259a46802c7",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/2b/535b99d0d582522eb70591f05207e78262cd48": "6562154b3686daa217ee96d2ef657fdc",
".git/objects/2d/0471ef9f12c9641643e7de6ebf25c440812b41": "d92fd35a211d5e9c566342a07818e99e",
".git/objects/3c/b3b53a24ee4712b8463133dca203ddd72fb43b": "c3066eae2c84f5465b93f0624f5ecfa6",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/4f/68ab94e28372ae561933fd47382dc159bb6b3e": "97c643c68124c0a90d2648a089cbb769",
".git/objects/51/88e7bf5273d6f1dde4328b67172e0e3b931ca1": "3ae6eb7e07cc137c7f2e559ec2bbf879",
".git/objects/58/1002fc37d9a1cabc0e05e34c40a6aab9cc548a": "87e9efb290c83b3bcdaa3459ea0fd1be",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/62/c89ee094658c7a9465824fdb42793a64ea557b": "133cd5da638f245b079d9e9cdc29ae38",
".git/objects/63/3ef6a5557af1f67cdb2e61e2ebb9196234b45b": "aa5726dba140348a9f0668347fdac5c5",
".git/objects/65/fb4c7fb863496a3e686cb01f908b8d756d915e": "a3a33cd044647442722d939679cdae5b",
".git/objects/6d/c3a4b50706fae9f02380cfd1cf396538c6eee1": "1e61b43e5ee6ac0436c41baf53aadd6a",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/74/02087c3fb58abc3fbe22100d6c0871b0aa2da0": "7d4c69031698753f333483851c884d99",
".git/objects/7d/9c587c275f21826879cf47afcafa2ed4b8e29e": "34c07e9d1ff80a39064effa68bcea099",
".git/objects/7e/780bcd42b7b816274e1bdb4122f0cdc81d0f63": "50b3e039b93f1095596f2627ec67fc9f",
".git/objects/82/94419dcd4f96a539e331d3f924d20321b01d9c": "959293f180b929b1cc5b99a3fdae1bf4",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/93/d6eaaff43211eacb03d62985a6df2e0bc3f2c9": "3211edb4b25b395769e0e146f9751a04",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/9b/ee0a7a1015ff2ca397cc85b46aee2c1a80e74c": "f48ae3756f564f5603ffa34781ce4a73",
".git/objects/9c/810314d7c30a05f8bba88856af8e4092991630": "312baa831b67a9cab4023a785e8355a7",
".git/objects/a7/6aef7d777aca3cd5bfc246897118995d7c9c41": "1cc0cc9eb1dbcc0c1096efefadca46b7",
".git/objects/aa/6247ac7448554e34d2a58a44021d7b6beda40b": "7e416507d1d7cf39a5e0ca0f76cf1e23",
".git/objects/ac/9522421034e2e4d050baa1fc17ec2ddab5b538": "8bc6f6673f9e07809ce009b777be1ef7",
".git/objects/ac/dff003233d90b91aebe67dcd38d5049aacda7b": "6fea100e06e06948e49143e92be1a8dd",
".git/objects/b3/27afbec9cf60756d658397406dfb449a8601d4": "8dadb263f38f8ba83357d27c08132adf",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b7/0db1317c4fd2085951e13359c6d6cbd3fcab27": "200a3d0215f0ed62d33b41dc0d68f385",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/cf/da9062b0519b68ece6e7a1d14eb54d63d2793c": "e3ee43534bde2d6c72ac5151963e8b9c",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/8218b0679dc5fc93673192c189c016965f5fe7": "90a8b70bce07550c2991126c5fc65516",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/1c32deb43f759d6c926f671daf3a5939b3eae2": "74a5ee0f1e115b99169aac4e13fbf6c5",
".git/objects/d9/7e31e9666444ba0e29e4f937a42ccb92abf761": "eb3e6eeadc9cf65150260b55ac4ed01d",
".git/objects/e8/d39e572b108ae79c2b6c1a357cc15490c80613": "27a91fb358e90629f4c772b12198636f",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/9f7f766d18dfcc833f20e21aad1b6fb7f967ec": "facd6c28cd7af93689ac63bb46533b26",
".git/refs/heads/main": "50828d5738d94f2233d1a950fb0fb46c",
".git/refs/remotes/origin/main": "50828d5738d94f2233d1a950fb0fb46c",
"assets/AssetManifest.bin": "fb47ad01a44e13a388b02dfae590a6e1",
"assets/AssetManifest.bin.json": "ee20cd95d9be825b65945c7b6c4b96b4",
"assets/AssetManifest.json": "ab84617e4e4d9e85577d4a38a09ffa1b",
"assets/assets/images/BackGround.png": "bf8ab79deb8f533f754ba4180cda43b7",
"assets/assets/images/BG.png": "8a9f8e0ceaf586b99e16b0cc907a77ed",
"assets/assets/images/BG1.png": "e18900c24f7025eda7c49344e57f4c45",
"assets/assets/images/BG2.png": "eb2a54d5d4b204b548e138a6346b4951",
"assets/assets/images/BG3.png": "da9adc315509ed1c3b5e42ff3bf12667",
"assets/assets/images/blob.jpeg": "c61512aad4a5802bd4a1d6c67843b671",
"assets/assets/images/mr.png": "bc15a81aa442565e24965b03befb747c",
"assets/assets/images/mr3.png": "956e33b219135aa63c60ca7ab9306fe7",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "190dd1b0e192b77eaf7ee2899a52cc00",
"assets/NOTICES": "54489fac634786966dba244811c18c15",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/toast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/toast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/web/index.html": "b8e43591470d68b3a2671497af4d1fd8",
"assets/web/manifest.json": "322bc5d81ab8b7a05e7b2ed7b31afa99",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "cbfd61a10581c6bca1b9113a3f7d13e7",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "9852b2b99b97889b5c8608937b903992",
"/": "9852b2b99b97889b5c8608937b903992",
"main.dart.js": "95fcdbb0aed1b2b28765c36a6412cdf3",
"manifest.json": "322bc5d81ab8b7a05e7b2ed7b31afa99",
"version.json": "9f957273a2b25d9abe8d893f40509dbe"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
