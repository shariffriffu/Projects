document.addEventListener("DOMContentLoaded", function() {
    var createButton = document.getElementById("createButton");
    var saveButton = document.getElementById("saveButton");

    createButton.addEventListener("click", createFile);
    saveButton.addEventListener("click", saveFile);

    var textInput = document.getElementById("textInput");

    textInput.addEventListener("input", function() {
        saveButton.disabled = textInput.value.trim() === "";
    });
});

function createFile() {
    var fileName = "note.txt";

    window.resolveLocalFileSystemURL(cordova.file.dataDirectory, function(dirEntry) {
        dirEntry.getFile(fileName, { create: true, exclusive: false }, function(fileEntry) {
            console.log("File created successfully!");
            document.getElementById("saveButton").disabled = false;
        }, onError);
    }, onError);
}

function saveFile() {
    var textInput = document.getElementById("textInput").value;
    var fileName = "note.txt";

    window.resolveLocalFileSystemURL(cordova.file.dataDirectory, function(dirEntry) {
        dirEntry.getFile(fileName, { create: false, exclusive: false }, function(fileEntry) {
            fileEntry.createWriter(function(fileWriter) {
                fileWriter.onwriteend = function() {
                    console.log("File saved successfully!");
                };

                fileWriter.onerror = function(e) {
                    console.log("Save failed: " + e.toString());
                };

                var blob = new Blob([textInput], { type: "text/plain" });
                fileWriter.write(blob);
            }, onError);
        }, onError);
    }, onError);
}

function onError(err) {
    console.error(err);
    alert("An error occurred: " + err.code);
}
