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

                    $sql = "UPDATE Sunglasses SET 01_sunglasses = 0";

                    if (mysqli_query($kobling, $sql)) {
                        echo "Record updated successfully";
                    } else {
                        echo "Error updating record: " . mysqli_error($kobling);
                    }

                    $sql1 = "UPDATE PartyFace SET 02_party_face = 0";

                    if (mysqli_query($kobling, $sql1)) {
                        echo "Record updated successfully";
                    } else {
                        echo "Error updating record: " . mysqli_error($kobling);
                    }

                    $sql2 = "UPDATE Melting SET 03_melting = 0";

                    if (mysqli_query($kobling, $sql2)) {
                        echo "Record updated successfully";
                    } else {
                        echo "Error updating record: " . mysqli_error($kobling);
                    }

                    $sql3 = "UPDATE Lazy SET 04_lazy = 0";

                    if (mysqli_query($kobling, $sql3)) {
                        echo "Record updated successfully";
                    } else {
                        echo "Error updating record: " . mysqli_error($kobling);
                    }

                    // mysqli_query($kobling, "TRUNCATE TABLE Sunglasses");
                    // mysqli_query($kobling, "TRUNCATE TABLE PartyFace");
                    // mysqli_query($kobling, "TRUNCATE TABLE Melting");
                    // mysqli_query($kobling, "TRUNCATE TABLE Lazy");
                }

                mysqli_close($kobling);

                
            ?>
    </div>
</body>
</html>