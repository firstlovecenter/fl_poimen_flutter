window.addEventListener("load", () => {
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.has("code") && urlParams.has("state")) {
    window.location.href = "https://poimen.firstlovecenter.com/";
  }
});
