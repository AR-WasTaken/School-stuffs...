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

    // Med linjeskift for 1 tabell    
    $sql = "SELECT * FROM Elever JOIN Klasse ON Elever.Klasse_idKlasse = Klasse.idKlasse"; //Skriv din sql kode her
    //$sql = "SELECT Fornavn, Etternavn, Klasse_id_Klasse FROM Elever JOIN mydb.Klasse ON Elev.Klasse_id_Klasse = Klasse.idKlasse"; 
    $resultat = $kobling->query($sql);

    while($rad = $resultat->fetch_assoc()) {
        $idElever = $rad["idElever"]; //Skriv ditt kolonnenavn her
        $Fornavn = $rad["Fornavn"];
        $Etternavn = $rad["Etternavn"];

        $idKlasse = $rad["idKlasse"];
        $KlasseromNummerGreie = $rad["KlasseromNummerGreie"];



        echo "

        <style>
            table, th, td {border:1px solid black;}

            body {
                justify-content: center;
                align-items: middle;
            }
        </style>

        <table style='width:100%'>
            <tr> <br>
                <th><b>$idElever</b></th>
                <td>$Fornavn</td>
                <td>$Etternavn</td>
            </tr>
            <tr>
                <td><b>$idKlasse</b></td>
                <td>$KlasseromNummerGreie</td>
            </tr>
        </table>

        ";
    }
    ?>

    <style>
    </style>
</body>
</html>