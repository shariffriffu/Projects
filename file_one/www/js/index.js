document.addEventListener("deviceready", onDeviceReady, false);

function onDeviceReady() {
    // Device is ready, you can use Cordova plugins here.
}

function saveData() {
    var data = document.getElementById("dataInput").value;
    if (data.trim() === "") {
        alert("Please enter some data.");
    } else {
        prompt("Enter a name to save the data:", function (fileName) {
            if (fileName.trim() !== "") {
                // Requesting file system access
                window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function (fs) {
                    // Creating or getting the file
                    fs.root.getFile(fileName + ".txt", { create: true, exclusive: false }, function (fileEntry) {
                        // Writing the data to the file
                        fileEntry.createWriter(function (fileWriter) {
                            fileWriter.onwriteend = function () {
                                alert("Data saved successfully!");
                            };
                            fileWriter.onerror = function (e) {
                                alert("Error saving data: " + e.toString());
                            };
                            fileWriter.write(data);
                        }, errorHandler);
                    }, errorHandler);
                }, errorHandler);
            } else {
                alert("Please enter a valid file name.");
            }
        });
    }
}

function errorHandler(error) {
    alert("Error: " + error.code);
}
