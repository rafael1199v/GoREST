function fn() {
    var generateRandomNumber = function (max, min) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    };

    var generateRandomTitle = function() {
        let size = generateRandomNumber(7, 15);
        let title = "";

        for(let index = 0; index < size; index++) {
            let asciiCharacter = 97;
            let randomNumber = generateRandomNumber(0, 25);
            title += (String.fromCharCode(asciiCharacter + randomNumber));
        }

        return title;
    }


    var generateRandomBody = function() {
        let size = generateRandomNumber(100, 150);
        let body = "";

        for(let index = 0; index < size; index++) {
            let asciiCharacter = 97;
            let randomNumber = generateRandomNumber(0, 25);
            body += (String.fromCharCode(asciiCharacter + randomNumber));
        }

        return body;
    }

    var chooseRandomItem = function(array) {
        const randomIndex = Math.floor(Math.random() * array.length);
        return array[randomIndex];
    }

    return {
        generateRandomNumber: generateRandomNumber,
        generateRandomBody: generateRandomBody,
        generateRandomTitle: generateRandomTitle,
        chooseRandomItem: chooseRandomItem
    }
}

