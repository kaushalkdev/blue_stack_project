const express = require('express');


const app = express();


app.get('/users', (request, response) => {
    response.send({
        "userName": "Simon Baker",
        "userImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh7cbzanUs7T_w7x4ae--MoMyk_P62AOjo9Q&usqp=CAU",
        "eloRating": 2250,
        "tournamentPlayed": 21,
        "tournamentWon": 11,
        "winningPercentage": 26
    });
})

app.get('/', (request, response) => {
    response.send({ "success": true });
})


// start listening to server
app.listen(3000);




