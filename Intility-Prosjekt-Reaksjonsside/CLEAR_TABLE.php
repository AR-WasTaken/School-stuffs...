<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secret</title>

    <style>
        body {
            background-image: url('img/background-assets/background_loading_placeholder.svg');
            background-size: 100vw 100vh;
        }
    </style>

    <script>
        function goBack() {
            window.location.assign("_index.php");
        }
    </script>

</head>

<body onload="goBack();">

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

                if (isset($_POST['clear'])) {

                mysqli_query($kobling, "TRUNCATE TABLE Rooms");
                }

                mysqli_close($kobling);
            ?>
    </div>
</body>
</html>