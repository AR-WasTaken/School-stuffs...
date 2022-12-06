<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php
            // Tilkoblingsinformasjon
        $tjener = "localhost";
        $brukernavn = "root";
        $passord = "root";
        $database = "mydb"; //Endre på denne til din database

        // Opprette en kobling
        $kobling = new mysqli($tjener, $brukernavn, $passord, $database);

        // Sjekk om koblingen virker
        if($kobling->connect_error) {
            die("Noe gikk galt: " . $kobling->connect_error);
        } else {
            echo "Koblingen virker.<br>";
        }

        // Angi UTF-8 som tegnsett
        $kobling->set_charset("utf8");

        $idHund = $_GET["idHund"]
        $fornavn = $_GET["fornavn"];
        $etternavn = $_GET["etternavn"];
        $rase = $_GET["rase"];
        $størrelse_CM = $_GET["størrelse_CM"];
        $farge = $_GET["farge"];
        

        $sql = "INSERT INTO Hund (idHund, fornavn, etternavn, rase, størrelse_CM, farge, Eier_idEier) VALUES ('$idHund','$fornavn','$etternavn','$rase','$størrelse_CM','$farge')";

        if($kobling->query($sql)) {
            echo "Spørringen $sql ble gjennomført.";
        } else {
            echo "Noe gikk galt med spørringen $sql ($kobling->error).";
        }	


    ?>
</body>
</html>