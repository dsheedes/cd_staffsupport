let soundAvailable = true;

let holytroll1;
let holytroll2;


window.onload = () => {
    holytroll1 = new Audio('sound/holytroll1.ogg');
    holytroll2 = new Audio('sound/holytroll2.ogg');
}

function playSound(sound){
    if(soundAvailable){ // Check if the sound stopped playing
        soundAvailable = false; // Set the avaliability to false, since we are going to play it now.
        holytroll1.volume = 0.5; // Set the volume to 0.5 (or adjust to your own preference)
        holytroll2.volume = 0.5;
        if(sound == "holytroll1"){
            holytroll1.play().then(() => {
                holytroll1.currentTime = 0; // Reset the position to start
                soundAvailable = true; // Sound stopped playing, so it is now avaliable
            });
        } else {
            holytroll2.play().then(() => {
                holytroll2.currentTime = 0; // Reset the position to start
                soundAvailable = true; // Sound stopped playing, so it is now avaliable
            });
        }
      }
}

window.addEventListener("message", (event) => {
    playSound(event.data.sound);
});