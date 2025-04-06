/**
 * Flutter Web Bootstrap
 * This file ensures proper initialization of Flutter web applications.
 */

// Bootstrap Flutter application
window.addEventListener('load', function() {
  // Get serviceWorkerVersion from window
  const serviceWorkerVersion = window.flutter_service_worker_version || null;
  
  // Check if Flutter is already loaded
  if ('serviceWorker' in navigator) {
    // Register service worker if available
    if (serviceWorkerVersion) {
      navigator.serviceWorker.register(
        'flutter_service_worker.js?v=' + serviceWorkerVersion
      );
    }
  }

  // Load main Flutter script
  const scriptLoaderPromise = new Promise((resolve) => {
    const scriptTag = document.createElement('script');
    scriptTag.src = 'main.dart.js';
    scriptTag.type = 'application/javascript';
    scriptTag.onload = resolve;
    document.body.appendChild(scriptTag);
  });

  // Initialize Flutter app
  scriptLoaderPromise.then(() => {
    console.log('Flutter web application bootstrap completed');
  });
});
