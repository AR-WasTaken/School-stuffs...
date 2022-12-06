<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <form action="4.3.1.1hent_data_ut_fra_en_tabel.php" method="get">
        ID: <input type="text" name="idHund"><br>
        Fornavn: <input type="text" name="fornavn"><br>
        Etternavn: <input type="text" name="etternavn"><br>
        Rase: <input type="text" name="rase"><br>
        størrelse_CM <input type="text" name="størrelse_CM"> <br>
        farge <input type="text" name="farge"><br>
<br>
        Eier: 
        <?php
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
                echo "<script>console.log('Koblingen virker')</script>";
            }

            $sql = "SELECT * FROM Eier"; //Skriv din sql kode her
            $resultat = $kobling->query($sql);

            echo "<select name='idEier'>";
            while($rad = $resultat->fetch_assoc()) {
                $id = $rad["idEier"]; //Skriv ditt kolonnenavn her
                $fornavn = $rad["fornavn"];
                $etternavn = $rad["etternavn"];

                echo "<option value='$id'>$fornavn $etternavn</option>";
            }
            echo "</select>"

        ?><br>

        <input type="submit" value="Send inn">

    </form>
</body>
</html>