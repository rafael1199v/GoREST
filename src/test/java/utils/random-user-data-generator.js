function fn() {
    var generateRandomNumber = function (max, min) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    };

    var generateRandomName = function() {
        let size = generateRandomNumber(5, 10);
        let name = "";

        for(let index = 0; index < size; index++) {
            let asciiCharacter = 97;
            let randomNumber = generateRandomNumber(0, 25);
            name += (String.fromCharCode(asciiCharacter + randomNumber));
        }

        return name;
    };

    var generateRandomEmail = function () {
        let size = generateRandomNumber(10, 15);
        let email = "";

        for(let index = 0; index < size; index++) {
            let asciiCharacter = 97;
            let randomNumber = generateRandomNumber(0, 25);
            email += (String.fromCharCode(asciiCharacter + randomNumber));
        }

        email += "@gmail.com";

        return email;
    };

    var generateRandomGender = function () {
        const genderList = ["male", "female"];
        const randomIndex = Math.floor(Math.random() * genderList.length);

        return genderList[randomIndex];
    }

    var generateRandomStatus = function () {
        const statusList = ["active", "inactive"];
        const randomIndex = Math.floor(Math.random() * statusList.length);

        return statusList[randomIndex];
    }

    return {
        generateRandomNumber: generateRandomNumber,
        generateRandomName: generateRandomName,
        generateRandomEmail: generateRandomEmail,
        generateRandomGender: generateRandomGender,
        generateRandomStatus: generateRandomStatus
    }
}

