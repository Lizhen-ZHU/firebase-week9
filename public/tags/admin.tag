<admin>
  <div class="memeMaker">
    <input type="text" ref="urlEl" placeholder="Enter url">
    <input type="text" ref="captionEl" placeholder="Enter caption">
    <input type="text" ref="funnyEl" placeholder="Enter funness (0 to 5)">
    <button type="button" onclick={ saveMeme }>Add Meme</button>
  </div>

  <div class="order">
    <p>order data by</p>
    <select ref="order" value="" onchange={ orderResults }>
      <option value="default">default</option>
      <option value="funnees">funnees</option>
      <option value="caption">caption</option>
    </select>
  </div>

  <div class="filter">
    <p>filter by level of fun</p>
    <select ref="fun" value="" onchange={ filterResults }>
      <option value="default">Default</option>
      <option value="nofun">No Fun</option>
      <option value="somewhatfun">Some Fun</option>
      <option value="veryfun">Very Fun</option>
    </select>
  </div>

  <div show={ myMemes.length == 0 }>
    <p>NO MEMEs. Add a meme from above.</p>
  </div>

  <admin_entry each={ myMemes }></admin_entry>

  <script>

    var tag = this;

    //local database is always empty, and read dynamicly from fb.
    this.myMemes = [];

    //prepare to push into memes subdirectory in our database
    var messagesRef = rootRef.child('/memes');

    this.saveMeme = function () {
      var key = messagesRef.push().key;
      var meme = {
        id: key,
        url: this.refs.urlEl.value,
        caption: this.refs.captionEl.value,
        funness: this.refs.funnyEl.value
      }
      messagesRef.child(key).set(meme);

      //clean up default input values
      this.refs.urlEl.value = "";
      this.refs.captionEl.value = "";
      this.refs.funnyEl.value = "";
    }

    // listen to database value change and update result
    messagesRef.on('value', function (snap) {
      let rawdata = snap.val();

      let tempData = [];
      for (key in rawdata) {
        tempData.push(rawdata[key]);
      }

      tag.myMemes = tempData;

      tag.update();

    })

    orderResults() {
      //1. get order value
      let order = this.refs.order.value;


      let orderResult = messagesRef;


      // if order is selected as funnies, then order messages by child propoerty funness if order is selected as caption, then order messages by child propoerty caption if order is elected as default, no need to reorder at specifically

      if (order == 'funness') {
        orderResult = orderResult.orderByChild('funness');
      } else if (order == 'capltion') {
        orderResult = orderResult.orderByChild('capltion');
      } else if (order == 'default') {}

      orderResult.once('value', function (snap) {
        //let rawdata = snap.val();
        let tempData = [];
        for (key in rawdata) {
          tempData.push(rawdata[key]);
        }

        snap.forEach(function (child) {
          tempData.push(child.val());
        });

        tag.myMemes = tempData;
        tag.update();

        // console.log("datafromfb", datafromfb); prepare an empty js array to store firebase data get each child value of the the snapshot, and push child.val() into our temporary database update our tag's myMemes property with sorted firebase data calling
        // our tag to manually update so that changes get reflected on the memes tab

      });
    }

    filterResults(event) {
        //get current filter value
        var fun = this.refs.fun.value;
        //order memes by child property funnees
        let queryResult = messagesRef.orderByChild('funness');


        //combine with additional functions to form complex queries
        if (fun == "nofun") {
          queryResult = queryResult.equalTo("0");

        } else if (fun == "veryfun") {
          queryResult = queryResult.equalTo("5");

        } else if (fun == "somewhatfun") {
          queryResult = queryResult.startAt('1').endAt('4');

        } else {
          //default, no query needed
        }

        queryResult.once('value', function (snap) {
          let rawdata = snap.val();

          let tempData = [];
          for (key in rawdata) {
            tempData.push(rawdata[key]);
          }

          tag.myMemes = tempData;

          tag.update();
          observable.trigger('updateMemes', tempData);
        });
      }
  </script>

  <style>
    :scope {
      display: block;
      padding: 2em;
    }

    .memeMaker {
      padding: 2em;
      margin-top: 2em;
      background-color: grey;
    }

    .order {
      padding: 2em;
      margin-top: 2em;
      background-color: powderblue;
    }

    .filter {
      padding: 2em;
      margin-top: 2em;
      background-color: steelblue;
    }
  </style>
</admin>
