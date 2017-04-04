var num = 0
// var contract_id = $('#contract_id').val();
// console.log(contract_id);

$('#jsAddUser').unbind().on('click', function() {
  addAnotherUser();
});

function addAnotherUser() {
  if (validateEmail($('#' + num + '-email').val())) {
      num++
      var userInput = `<input class='form-control form-email' id='` + num + `-email'type='email' name='email_` + num + `' autofocus placeholder='Email' autocomplete="off">
                          <div class='radio-buttons'>
                            <input type='radio' id='` + num + `-collab' name='position_` + num + `' value='collab' checked> Collaborator
                            <input type='radio' id='` + num + `-owner' name='position_` + num + `' value='owner'> Owner
                            <input type='radio' id='` + num + `-viewer' name='position_` + num + `' value='viewer'> Viewer
                          </div>`;

      $('#jsAddUser').before(userInput);
      $('#'+ num +'-email').focus()
  }
}


function validateEmail(sEmail) {
    var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
    if (filter.test(sEmail)) {
        return true;
    } else {
        return false;
    }
}

// stop form submit when pressing enter
$('#add_user_form').on('keyup keypress', function(e){
  var keyCode = e.keyCode || e.which;
  if (keyCode === 13) {
    e.preventDefault();
    addAnotherUser();
    return false;
  }
});
