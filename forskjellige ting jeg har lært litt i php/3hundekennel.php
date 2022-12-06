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
    $sql = "SELECT * FROM Eier JOIN postnummer ON postnummer.postnummer = Eier.Postnummer_postnummer JOIN Hund ON Eier.idEier = Hund.Eier_idEier"; //Skriv din sql kode her
    //$sql = "SELECT Fornavn, Etternavn, Klasse_id_Klasse FROM Elever JOIN mydb.Klasse ON Elev.Klasse_id_Klasse = Klasse.idKlasse"; 
    $resultat = $kobling->query($sql);

    while($rad = $resultat->fetch_assoc()) {
        $idEier = $rad["idEier"]; //Skriv ditt kolonnenavn her
        $fornavn = $rad["fornavn"];
        $etternavn = $rad["etternavn"];

        $gatenummer = $rad["gatenummer"];
        $telefonnummer = $rad["telefonnummer"];

        $postnummer = $rad["postnummer"];
        $poststed = $rad["poststed"];

        $idHund = $rad["idHund"]; //Skriv ditt kolonnenavn her
        $navn = $rad["navn"];
        $rase = $rad["rase"];
        $størrelse_CM = $rad["størrelse_CM"];
        $farge = $rad["farge"];



        echo "

        <style>
            table, th, td {border:1px solid black;}

            body {
                justify-content: center;
                align-items: middle;
            }

            td {
                width: 20em;
            }
        </style>

        <table style='width:80%'>
            <tr> <br>
                <th>$idEier</th>
                <td>$fornavn</td>
                <td>$etternavn</td>
                <td>$gatenummer</td>
                <td>$telefonnummer</td>
                <br>
                <td>$postnummer</td>
                <td>$poststed</td>
            </tr>
            <tr>
                <th>$idHund</th>
                <td>$navn</td>
                <td>$rase</td>
                <td>$størrelse_CM</td>
                <td>$farge</td>
            </tr>
        </table>

        ";
    }
    ?>

    <style>
    </style>
</body>
</html>