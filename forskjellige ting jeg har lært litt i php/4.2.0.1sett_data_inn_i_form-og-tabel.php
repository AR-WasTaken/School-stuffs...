<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>


<form action="4.0.0.1sett_data_inn_i_tabell.php" method="post">
    postnummer: <input type="text" id="postnummer"> <br>
    poststed: <input type="text" id="poststed"><br>

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


    $sql = "INSERT INTO postnummer (postnummer, poststed) VALUES ($postnummer $poststed)"; //Skriv din sql kode her

    $resultat = $kobling->query($sql);
    ?>

    <style>
    </style>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="legg_til_elever.php" method="get">
        Fornavn: <input type="text" name = "etternavn"><br>
        Etternavn: <input type="text" name = "fornavn"><br>
        Klasse: 
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

            $sql = "SELECT * FROM Klasse"; //Skriv din sql kode her
            $resultat = $kobling->query($sql);

            echo "<select name='klasse_id'>";
            while($rad = $resultat->fetch_assoc()) {
                $id = $rad["idKlasse"]; //Skriv ditt kolonnenavn her
                $navn = $rad["navn"];

                echo "<option value='$id'>$navn</option>";
            }
            echo "</select>"

        ?>
        <input type="submit" value="Send inn">

    </form>
</body>
</html>