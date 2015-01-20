$(document).ready ->
  window.itemList = new beehive.HoneycombItemList(2)
  itemList.load ->
    console.log(itemList.objectsByID)
