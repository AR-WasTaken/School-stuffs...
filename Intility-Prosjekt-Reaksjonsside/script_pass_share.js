function pass_share() {
    var b = document.getElementById('USERNAME').value,
        url = 'pass.html' + encodeURIComponent(b);

    document.location.href = url;
}