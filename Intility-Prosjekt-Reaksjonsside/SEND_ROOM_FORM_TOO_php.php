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
            window.location.href = "_index.php";
        }
    </script>

</head>

<body onload="goBack();">

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

                $RoomName = $_POST['RoomName'];

                $RoomName = "R" . "(n)" . " - " . $RoomName;


                if ($RoomName == null || $RoomName == "undefined" || $RoomName == "R(n) - ") {
                    $RoomName = "R(n) - Template Name";
                }
                if (isset($_POST["increment"])) {
                    for ($i = 2; $i <= 3; $i++) {


                        // echo "<div class='room-list-flex-items' id='room" . $id . "'>
                        //     <h3> R" . "3" . " - " . $_RoomName . "</h3>
                        // </div>";
                    }
                }

                $sql = "INSERT INTO Rooms (RoomName) VALUES ('$RoomName')";


                if($kobling->query($sql)) {
                    // echo "Spørringen $sql ble gjennomført.";
                } else {
                    // echo "Noe gikk galt med spørringen $sql ($kobling->error).";
                }
            ?>
    </div>
</body>
</html>