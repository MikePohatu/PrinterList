$(document).foundation();

function onCloseClicked() {
    try {
        //https://stackoverflow.com/questions/12314729/close-windows-that-were-not-opened-by-script-using-javascript
        open(location, '_self').close();
    }
    catch (e) {
        confirm("Please close browser window");
    }

}

$('#createBtn').on('click', function (event) {
    event.preventDefault();

    const name = $('#name').val();
    const ip = $('#ip').val(); 
    const driver = $('#driver').val();
    const comment = $('#comment').val();
    const location = $('#location').val();

    window.location.href = `setupprinter:${name};${ip};${driver};${comment};${location}`;
});