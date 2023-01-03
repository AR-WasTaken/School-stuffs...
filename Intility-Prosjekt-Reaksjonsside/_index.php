<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reaction_Heaven</title>

    <link rel="stylesheet" href="style.css">

    <link rel="icon" type="image/x-icon" href="img-pass/favicon.png">

    <script src="script_pass_share.js"></script>

    <script>
        var favicon_images = [
                'img/favicon/1.ico',
                'img/favicon/2.ico',
                'img/favicon/3.ico',
                'img/favicon/4.ico',
                'img/favicon/5.ico',
                'img/favicon/6.ico',
                'img/favicon/7.ico',
            ],
            image_counter = 0;

        var fullRoomName = "R0 - Personal Room"

        setInterval(function() {
            if (document.querySelector("link[rel='icon']") !== null)
                document.querySelector("link[rel='icon']").remove();
            if (document.querySelector("link[rel='shortcut icon']") !== null)
                document.querySelector("link[rel='shortcut icon']").remove();

            document.querySelector("head").insertAdjacentHTML('beforeend', '<link rel="icon" href="' + favicon_images[image_counter] + '" type="image/gif">');

            if (image_counter == favicon_images.length - 1)
                image_counter = 0;
            else
                image_counter++;
        }, 1000);

        function getUsername() {
            var username = localStorage.getItem("username");
            console.log(username)
            document.getElementById('username_field').value = username;
            document.getElementById('username_field_1').value = username;
            document.getElementById('username_field_2').value = username;
            document.getElementById('username_field_3').value = username;

            document.getElementById('USERNAME').innerHTML = username;            

            // username checker :)
            if (username === null || username === "undefined" || username === "") {
                username = "Guest User"
            }

        }


        //might work on if I have the time [[[WWORK ON LATER]]]

        // function opacityRoomChange() {
        //     var roomAmount = 5
        //     for (let i = 1; i <= roomAmount; i++) {
        //         document.getElementById("room" + i).style.opacity = "0.2";
        //     }
        // }

        // var i = 3
        // var z = 2
    </script>

    <style>
        body {
            background-image: url('img/background-assets/background.png');
            background-size: 100vw 100vh;
            overflow: hidden;
        }
    </style>
</head>

<body onload="getUsername();">
    <div class="container">
        <div class="rooms-list">
            <div class="temp">
                <div class="flex-container-styles room-list-flex-container all-rooms">
                    <div class="room-list-flex-items" id="room1" onclick="opacityRoomChange(); roomChangeSlide(); insertRoomName();">
                        <h3>R(0) - Personal Room</h3>
                    </div>

                    <div class="room-list-flex-items" id="room2">
                        <h3>R(1) - Main Room</h3>
                    </div>

                        <?php 
                            $tjener = "localhost";
                            $brukernavn = "root";
                            $passord = "root";
                            $database = "mydb";

                            $kobling = new mysqli($tjener, $brukernavn, $passord, $database);

                            $sql = "SELECT * FROM Rooms";
                            $result = mysqli_query($kobling, $sql);

                            while ($row = mysqli_fetch_assoc($result)) {
                                echo "<div class='room-list-flex-items' id='room" . $id . "'>
                                    <h3>" . $row['RoomName'] . "</h3>
                                </div>";
                            }
                        ?>
                    <nav>
                        <!-- MORE ROOMS ARE ADDED BY USER ^^^^^ HERE -->
                    </nav>
                </div>
                <div>
                    <div>
                        <form action="CLEAR_TABLE.php" method="post" style="margin-left: 24%;">
                            <button id="test" class="button" type="submit" name="clear">Clear Rooms</button>
                        </form>
                    </div>

                    <style>
                        .button {
                            z-index: 10000;
                            background-color: white;
                            background-color: rgba(186,176,158,255);
                            margin: 15px;
                            border-radius: 5px;
                            border: 2px solid black;
                            cursor: pointer;
                            padding: 1px 5px;
                            margin-top: -0px;

                        }   
                    </style>

                    <script>
                        let link = document.querySelector("button#test");

                        link.addEventListener("click", function(event) {
                        if (!confirm("Are you sure you want to deleate all rooms?")) {
                            event.preventDefault();
                        }
                        });
                    </script>
                </div>
            </div>        
        </div>

        <div class="add-room">
            <div class="flex-container-styles add-room-flex-container">
                <div class="add-room-flex-items"  style="cursor: default;">
                    <br>
                    <form method='post' action='SEND_ROOM_FORM_TOO_php.php'>
                        <input type="text" id="roomName" class="input-field" name="RoomName" placeholder="Room Name">
                        <button type="submit" name="increment" class="btn-round" style="cursor: pointer;">+</button>
                        <!-- ADD USER ADDED ROOM -->
                        <!-- onclick="getRoomName();" ^^^^^^^^^^ -->
                    </form>
                </div>
                <h2>Hi <span id="USERNAME"></span></h2>
            </div>
        </div>

        <div class="reactions">
            <div class="flex-container-styles reactions-flex-container" style="overflow: hidden;">
                <div class="reactions-flex-items" style="cursor: default;">
                    <h1 id="fullRoomName" onload="insertRoomName();">R(0) - Personal Room</h1>
                </div>
                <div class="reactions-flex-items" style="cursor: default; margin-bottom: 10em;">
                
                
                    <div style="position: fixed; margin-left: 0; margin-top: -2%;">
                        <form action="CLEAR_REACTIONS.php" method="post">
                            <button id="delReactions" class="button" type="submit" name="clear">Clear Reactions</button>
                        </form>
                    </div>

                    <script>
                        let link = document.querySelector("button#delReactions");

                        link.addEventListener("click", function(event) {
                        if (!confirm("Are you sure you want to deleate all reactions?")) {
                            event.preventDefault();
                        }
                        });
                    </script>

                    <div class="container-reactions" style="margin-bottom: -12px;">
                        <div class="area-1-1 area-reactions-inside center">

                            <form method="post" action="send_emoji/SEND_EMOJI_SUNGLASSES_TOO_php.php">
                                <button type="submit" style="border: 0; background-color: rgba(0,0,0,0);">
                                    <img src="img/emoji/01_smiling_face_with_sunglasses.png" alt="" style="cursor: pointer;">
                                </button>
                                <input type="hidden" name="username" id="username_field">
                            </form>

                        </div>
                        <div class="area-1-2 area-reactions-inside center">
                             <h1>
                                <span id="area_1_1__amount_of_reaction">
                                    <?php 
                                        $tjener = "localhost";
                                        $brukernavn = "root";
                                        $passord = "root";
                                        $database = "mydb";
                        
                                        $kobling = new mysqli($tjener, $brukernavn, $passord, $database);
                        
                                        // Sjekk om koblingen virker
                                        // if($kobling->connect_error) {
                                        //     die("Noe gikk galt: " . $kobling->connect_error);
                                        // } else {
                                        //     echo "Koblingen virker.<br>";
                                        // }

                                        $sql = "SELECT * FROM Sunglasses WHERE 01_sunglasses";
                                        $result = mysqli_query($kobling, $sql);

                                        if (mysqli_num_rows($result) > 0) {
                                            $row = mysqli_fetch_assoc($result);
                                            echo $row["01_sunglasses"];
                                        } else {
                                            echo "--";
                                        }
                                        mysqli_close($kobling);
                                    ?>
                                </span>
                            </h1>
                        </div>

                        <div class="area-2-1 area-reactions-inside">
                            <form method="post" action="send_emoji/SEND_EMOJI_PARTY_FACE_TOO_php.php">
                                <button type="submit" style="border: 0; background-color: rgba(0,0,0,0);">
                                    <img src="img/emoji/02_party_face.png" alt="" style="cursor: pointer;">
                                </button>
                                <input type="hidden" name="username" id="username_field_1">
                            </form>
                        </div>
                        <div class="area-2-2 area-reactions-inside">
                        <h1>
                                <span id="area_2_1__amount_of_reaction">
                                <?php 
                                        $tjener = "localhost";
                                        $brukernavn = "root";
                                        $passord = "root";
                                        $database = "mydb";
                        
                                        $kobling = new mysqli($tjener, $brukernavn, $passord, $database);
                        
                                        // Sjekk om koblingen virker
                                        // if($kobling->connect_error) {
                                        //     die("Noe gikk galt: " . $kobling->connect_error);
                                        // } else {
                                        //     echo "Koblingen virker.<br>";
                                        // }

                                        $sql = "SELECT * FROM PartyFace WHERE 02_party_face";
                                        $result = mysqli_query($kobling, $sql);

                                        if (mysqli_num_rows($result) > 0) {
                                            $row = mysqli_fetch_assoc($result);
                                            echo $row["02_party_face"];
                                        } else {
                                            echo "--";
                                        }
                                        mysqli_close($kobling);
                                    ?>
                                </span>
                            </h1>
                        </div>

                        <div class="area-3-1 area-reactions-inside">
                            <form method="post" action="send_emoji/SEND_EMOJI_MELTING_TOO_php.php">
                                <button type="submit" style="border: 0; background-color: rgba(0,0,0,0);">
                                    <img src="img/emoji/03_melting.png" alt="" style="cursor: pointer;">
                                </button>
                                <input type="hidden" name="username" id="username_field_2">
                            </form>
                        </div>
                        <div class="area-3-2 area-reactions-inside">
                            <h1>
                                <span id="area_3_1__amount_of_reaction">
                                <?php 
                                        $tjener = "localhost";
                                        $brukernavn = "root";
                                        $passord = "root";
                                        $database = "mydb";
                        
                                        $kobling = new mysqli($tjener, $brukernavn, $passord, $database);
                        
                                        // Sjekk om koblingen virker
                                        // if($kobling->connect_error) {
                                        //     die("Noe gikk galt: " . $kobling->connect_error);
                                        // } else {
                                        //     echo "Koblingen virker.<br>";
                                        // }

                                        $sql = "SELECT * FROM Melting WHERE 03_melting";
                                        $result = mysqli_query($kobling, $sql);

                                        if (mysqli_num_rows($result) > 0) {
                                            $row = mysqli_fetch_assoc($result);
                                            echo $row["03_melting"];
                                        } else {
                                            echo "--";
                                        }
                                        mysqli_close($kobling);
                                    ?>
                                </span>
                            </h1>
                        </div>

                        <div class="area-4-1 area-reactions-inside">
                            <form method="post" action="send_emoji/SEND_EMOJI_LAZY_TOO_php.php">
                                <button type="submit" style="border: 0; background-color: rgba(0,0,0,0);">
                                    <img src="img/emoji/04_lazy.png" alt="" style="cursor: pointer;">
                                </button>
                                <input type="hidden" name="username" id="username_field_3">
                            </form>
                        </div>
                        <div class="area-4-2 area-reactions-inside">
                            <h1>
                                <span id="area_4_1__amount_of_reaction">
                                <?php 
                                        $tjener = "localhost";
                                        $brukernavn = "root";
                                        $passord = "root";
                                        $database = "mydb";
                        
                                        $kobling = new mysqli($tjener, $brukernavn, $passord, $database);
                        
                                        // Sjekk om koblingen virker
                                        // if($kobling->connect_error) {
                                        //     die("Noe gikk galt: " . $kobling->connect_error);
                                        // } else {
                                        //     echo "Koblingen virker.<br>";
                                        // }

                                        $sql = "SELECT * FROM Lazy WHERE 04_lazy";
                                        $result = mysqli_query($kobling, $sql);

                                        if (mysqli_num_rows($result) > 0) {
                                            $row = mysqli_fetch_assoc($result);
                                            echo $row["04_lazy"];
                                        } else {
                                            echo "--";
                                        }
                                        mysqli_close($kobling);
                                    ?>
                                </span>
                            </h1>
                        </div>

                    </div>
                </div>

            </div>
        </div>

        <div class="reactions-log">
            <div class="flex-container-styles reactions-log-flex-container">
                <div class="reactions-flex-items" style="cursor: default;">
                    <h1 id="fullRoomName_Reactions">R(0) - Personal Room</h1>
                </div>
                <div class="" style="cursor: default;">
                    <div id="log-room1">
                        <?php 
                            $tjener = "localhost";
                            $brukernavn = "root";
                            $passord = "root";
                            $database = "mydb";

                            $kobling = new mysqli($tjener, $brukernavn, $passord, $database);

                            $sql = "SELECT colLogg FROM Logg";

                            $result = mysqli_query($kobling, $sql);

                            if (mysqli_num_rows($result) > 0) {
                            
                                while ($row = mysqli_fetch_assoc($result)) {
                                echo "
                                <div class='reactions-log-flex-items'>
                                     <h3>" . $row["colLogg"] . "</h3>
                                 </div>";
                            }
                            } else {
                            // echo "0 results";
                            }

                            // while ($row = mysqli_fetch_assoc($result)) {
                            //     echo "<div class='room-list-flex-items'>
                            //         <h3>" . $row['colLogg'] . "</h3>
                            //     </div>";
                            // }

                            // if($kobling->query($sql)) {
                            //         echo "Spørringen $sql ble gjennomført.";
                            //     } else {
                            //         echo "Noe gikk galt med spørringen $sql ($kobling->error).";
                            //     }
                        ?>

                            
                            
                        <nav3></nav3>
                    </div>
                </div>
            </div>
            <div style="position: absolute; margin-left: 1%; margin-top: -20px; z-index: 100;">
                <form method="post" action="CLEAR_LOGG.php">
                    <button type="submit" name="clear" id="delLogg" class="button">
                        clear Logg
                    </button>
                </form>
            </div>
            <script>
                let link = document.querySelector("button#delLogg");

                link.addEventListener("click", function(event) {
                if (!confirm("Are you sure you want to deleate the entire Logg?")) {
                    event.preventDefault();
                }
                });
            </script>
        </div>
    </div>

</body>

</html>