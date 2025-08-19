let form = document.getElementById("form");
let textInput = document.getElementById("textInput");
let dateInput = document.getElementById("dateInput");
let textarea = document.getElementById("textarea");
let msg = document.getElementById("msg");
let tasks = document.getElementById("tasks");
let add = document.getElementById("add");

form.addEventListener("submit", (e) => {
  e.preventDefault();
  formValidation();
});

let formValidation = () => {
  if (textInput.value === "") {
    msg.innerHTML = "oops, you didn't enter anything";
    console.log("complete and utter failure");
  } else {
    console.log("stirring success");
    msg.innerHTML = "";
  }
};

// need to make the submit button work by hitting enter from the textarea
// field for timestamp for any updates, or versions? notes field that appends, with. timestamp?