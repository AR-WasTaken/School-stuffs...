<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>


<form action="4sett_data_inn_i_tabell.php" method="post">
    postnummer: <input type="text" id="postnummer"> <br>
    poststed<input type="text" id="poststed"><br>

    <input type="submit" value="send inn">
</form>

    <?php
    $tjener = "localhost";
    $brukernavn = "root";
    $passord = "root";
    $database = "mydb";

    $kobling = new mysqli($tjener, $brukernavn, $passord, $database);

    // Sjekk om koblingen virker
    if($kobling->connect_error) {
        die("Noe gikk galt: " . $kobling->connect_error);
    } else {
        echo "Koblingen virker.<br>";
    }

    $kobling->set_charset("utf8");


    $postnummer = $_POST["postnummer"];
    $poststed = $_POST["poststed"];


    $sql = "INSERT INTO postnummer (postnummer, poststed) VALUES ($postnummer 'oslo')"; //Skriv din sql kode her

    $resultat = $kobling->query($sql);





    
    // while($rad = $resultat->fetch_assoc()) {
    //     $idEier = $rad["idEier"];
    //     $fornavn = $rad["fornavn"];
    //     $etternavn = $rad["etternavn"];

    //     $gatenummer = $rad["gatenummer"];
    //     $telefonnummer = $rad["telefonnummer"];

    //     $postnummer = $rad["postnummer"];
    //     $poststed = $rad["poststed"];

    //     $idHund = $rad["idHund"]; //Skriv ditt kolonnenavn her
    //     $navn = $rad["navn"];
    //     $rase = $rad["rase"];
    //     $størrelse_CM = $rad["størrelse_CM"];
    //     $farge = $rad["farge"];


        // if($kobling->query($sql)) {
        //     die("$sql ble OK");
        // } else {
        //     echo "$sql fungerer ikke";
        // }


        // echo "

        // <style>
        //     table, th, td {border:1px solid black;}

        //     body {
        //         justify-content: center;
        //         align-items: middle;
        //     }

        //     td {
        //         width: 20em;
        //     }
        // </style>

        // <table style='width:80%'>
        //     <tr> <br>
        //         <th>$idEier</th>
        //         <td>$fornavn</td>
        //         <td>$etternavn</td>
        //         <td>$gatenummer</td>
        //         <td>$telefonnummer</td>
        //         <br>
        //         <td>$postnummer</td>
        //         <td>$poststed</td>
        //     </tr>
        //     <tr>
        //         <th>$idHund</th>
        //         <td>$navn</td>
        //         <td>$rase</td>
        //         <td>$størrelse_CM</td>
        //         <td>$farge</td>
        //     </tr>
        // </table>

        // ";
    }

    ?>

    <style>
    </style>
</body>
</html>