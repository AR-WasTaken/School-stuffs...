<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secret</title>

    <style>
        body {
            background-image: url('../img/background-1.jpg');
            background-size: 100vw 100vh;

            color: white;
        }
    </style>

    <script>
        function goBack() {
            window.location.href = "_index.php";
        }
    </script>

</head>

<body onload="goBack();">

test

    <div style="opacity: 40%;">
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
                // echo "Koblingen virker.<br>";
            }


            // sql shit


            if($kobling->query($sql)) {
                // echo "Spørringen $sql ble gjennomført.";
            } else {
                // echo "Noe gikk galt med spørringen $sql ($kobling->error).";
            }
            ?>
    </div>
</body>
</html>