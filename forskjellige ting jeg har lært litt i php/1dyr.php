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
        echo "Koblingen virker.<br> <br>";
    }

    // Angi UTF-8 som tegnsett
    $kobling->set_charset("utf8");

    // Med linjeskift for 1 tabell    
    $sql = "SELECT * FROM mydb.dyr"; //Skriv din sql kode her
    $resultat = $kobling->query($sql);

    while($rad = $resultat->fetch_assoc()) {
        $idDyr = $rad["idDyr"]; //Skriv ditt kolonnenavn her
        $DyrFornavn = $rad["DyrFornavn"];
        $DyrEtternavn = $rad["DyrEtternavn"];
        $Rase = $rad["Rase"];
        $Sex = $rad["Sex"];

        echo "<span style='font-size: 40px;'>$idDyr $DyrFornavn $DyrEtternavn $Rase $Sex</span> <br>";
    }
    ?> 
    
    <span></span>
</body>
</html>