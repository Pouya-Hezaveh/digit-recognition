const canvas = document.querySelector("canvas"),
  clearCanvas = document.querySelector(".clear-canvas"),
  saveImg = document.querySelector(".save-img"),
  guessButton = document.querySelector(".guess-button"),
  eyeLogo = document.querySelector(".eye-logo"),
  eyeOutput = document.querySelector("eye-output"),
  ctx = canvas.getContext("2d");

// global variables with default value
let prevMouseX, prevMouseY, snapshot,
  isDrawing = false,
  brushWidth = 10,
  selectedColor = "#000";

const setCanvasBackground = () => {
  // setting canvas width/height.. offsetwidth/height returns viewable width/height of an element
  canvas.width = canvas.offsetWidth;
  canvas.height = canvas.offsetHeight;
  // setting whole canvas background to white, so the downloaded img background will be white
  ctx.fillStyle = "#efeee5";
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = selectedColor; // setting fillstyle back to the selectedColor, it'll be the brush color
  brushWidth = canvas.width / 10;
}

window.addEventListener("load", setCanvasBackground);
window.addEventListener("resize", setCanvasBackground);

const startDraw = (e) => {
  isDrawing = true;
  prevMouseX = e.offsetX; // passing current mouseX position as prevMouseX value
  prevMouseY = e.offsetY; // passing current mouseY position as prevMouseY value
  ctx.beginPath(); // creating new path to draw
  ctx.lineWidth = brushWidth; // passing brushSize as line width
  ctx.strokeStyle = selectedColor; // passing selectedColor as stroke style
  ctx.fillStyle = selectedColor; // passing selectedColor as fill style
  // copying canvas data & passing as snapshot value.. this avoids dragging the image
  snapshot = ctx.getImageData(0, 0, canvas.width, canvas.height);
}

const drawing = (e) => {
  if (!isDrawing) return; // if isDrawing is false return from here
  ctx.putImageData(snapshot, 0, 0); // adding copied canvas data on to this canvas

  ctx.lineTo(e.offsetX, e.offsetY); // creating line according to the mouse pointer
  ctx.stroke(); // drawing/filling line with color
}

clearCanvas.addEventListener("click", () => {
  ctx.clearRect(0, 0, canvas.width, canvas.height); // clearing whole canvas
  setCanvasBackground();
});

saveImg.addEventListener("click", () => {
  const link = document.createElement("a"); // creating <a> element
  link.download = `${Date.now()}.jpg`; // passing current date as link download value
  link.href = canvas.toDataURL(); // passing canvasData as link href value
  link.click(); // clicking link to download image
});

guessButton.addEventListener('click', see);
eyeLogo.addEventListener('click', see);

function see() {
  const drawing = canvas.toDataURL('image/jpeg');
  const formData = new FormData();
  formData.append('drawing', drawing);

  fetch("/see", {
    method: 'POST',
    mode: "no-cors",
    body: formData
  })
    .then(response => response.json())
    .then(data => {
      console.log(data); eyeOutput.textContent = data.msg
    })
    .then(showEyeOutput)
    .catch(error => {
      console.error('Error:', error);
    });
};

const showEyeOutput = () => {
  if (eyeOutput.textContent !== null) {
    eyeLogo.style.display = 'none';
    eyeOutput.style.display = 'flex';
    guessButton.style.display = 'none';

    // After 3 seconds, restore the previous state.
    setTimeout(() => {
      eyeLogo.style.display = 'flex';
      eyeOutput.style.display = 'none';
      guessButton.style.display = 'inline';
    }, 3000);
  }
};

canvas.addEventListener("mousedown", startDraw);
canvas.addEventListener("mousemove", drawing);
canvas.addEventListener("mouseup", () => isDrawing = false);
