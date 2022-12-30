<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secret</title>

    <style>
        body {
            background-image: url('../img/background-assets/background_loading_placeholder.svg');
            background-size: 100vw 100vh;
        }
    </style>

    <script>
        function goBack() {
            window.location.href = "../_index.php";
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
                    echo "Koblingen virker.<br>";
                }

                $sql = "UPDATE Sunglasses SET 01_sunglasses = 01_sunglasses + 1";

                if (mysqli_query($kobling, $sql)) {
                    echo "Record updated successfully";
                } else {
                    echo "Error updating record: " . mysqli_error($kobling);
                }


                // $nn = $_POST['nn'];

                // $sql = "INSERT INTO RoomList (RoomList) VALUES ('$nn')";

                // if($kobling->query($sql)) {
                //     echo "Spørringen $sql ble gjennomført.";
                // } else {
                //     echo "Noe gikk galt med spørringen $sql ($kobling->error).";
                // }
            ?>
    </div>
</body>
</html>