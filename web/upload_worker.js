var xhr;

self.addEventListener('message', async (event) => {
    var message = event.data.message;
    if (message != null && message == "cancel") {
        xhr.abort();
    } else {
        var file = event.data.file;
        var url = event.data.uri;
        var token = event.data.token;
            uploadFile(file, url, token);
    
    }
});

function uploadFile(file, url, token) {
    xhr = new XMLHttpRequest();

    var formdata = new FormData();
    var uploadPercent;
    formdata.append('avatar', file);

    var isOverSize = false;

    xhr.upload.addEventListener('progress', function (e) {
        if (e.lengthComputable) {
            uploadPercent = Math.floor((e.loaded / e.total) * 100);
            postMessage(uploadPercent);
        }
    }, false);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            if (xhr.status == 200) {
                postMessage("done|" + xhr.responseText);
            } else {
                if (isOverSize) {
                    postMessage("over-size");
                } else {
                    postMessage(xhr.responseText);
                }
            }
        }
    }
    xhr.onerror = function () {
        // only triggers if the request couldn't be made at all
        postMessage("error");
    };

    xhr.open('PUT', url, true);

    xhr.setRequestHeader("x-auth-token", token);

    xhr.send(formdata);
}