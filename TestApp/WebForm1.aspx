<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="TestApp.WebForm1" ClientIDMode="Static" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #play {
            background-color: green;
            width: 100%;
        }
        #hidden {
            background-color: black;
            width: 100%;
        }

        .card {
            width: 70px;
            height: 95px;
            background-image: url(Images/back.png);
            background-repeat: no-repeat;
            background-size: inherit;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="table">
            <div id="play"  class="Area">
                <div class="card" data-owner="" data-x="0" data-y="0" data-z="0"></div>
            </div>
            <div id="hidden" class="Area">
            </div>
        </div>
    </form>
</body>
<script src="Scripts/jquery-1.6.4.min.js"></script>
<script src="Scripts/jquery-ui-1.10.4.min.js"></script>
<script type="text/javascript">
    $(function () {
        var cardHeight = $(".card").height();
        $(".Area").height(cardHeight * 2);
    });

    function Card(jQueryCard)
    {
        var card = jQueryCard;
        var cardHeight = $(".card").height();
        var cardWidth = $(".card").width();
        var originalOffset = $("#table").offset();
        this.X = function () { return new Number(card.attr("data-x")); };
        this.X = function (value)
        {
            jQueryCard.attr("data-x", value);
            card.offset({ top: card.offset().top, left: (value * cardWidth) + originalOffset.left });
        }
        this.Y = function () { return new Number(card.attr("data-y")); };
        this.Y = function (value)
        {
            card.attr("data-y", value);
            card.offset({ top: (value * cardHeight) + originalOffset.top, left: card.offset().left });
        }
        this.Z = function () { return new Number(card.attr("data-z")); };
        this.Z = function (value)
        {
            card.attr("data-z", value);
            card.zIndex(value)
        }
    };

    $(".card").each(function () {
        var currentCard = new Card($(this));
        currentCard.X = currentCard.X;
        currentCard.Y = currentCard.Y;
        currentCard.Z = currentCard.Z;
    });

    $(".Area").droppable({ accept: ".card" })

    $(".card").draggable(
        {
            containment: "#table",
            grid: [70, 95],
            helper: "clone",
            stop: function (event, ui) {
                var original = $(this);
                var newX = Math.floor(ui.offset.left / 70);
                var newY = Math.floor(ui.offset.top / 95);
                var newCardStack = $(".card[data-x='" + newX +"'][data-y='" + newY + "']");
                //original.offset(ui.offset);
                var card = new Card($(this));
                card.X(newX);
                card.Y(newY);
            }
        }
        );
    //var autoCompleteData;

    //$(function () {
    //    alert("I reach this");
    //    $.ajax({
    //        url: "../Test.ashx/MiscData",
    //        success: function (data, status, jqXHR) {
    //            autoCompleteData = data;
    //            alert(data);
    //            $("input").autocomplete({
    //                source: function (request, response) {
    //                    var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(request.term), "i");
    //                    response($.grep(autoCompleteData, function (item) {
    //                        return matcher.test(item);
    //                    }));
    //                }
    //            });
    //        }
    //    });
    //});
</script>
</html>

