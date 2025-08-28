function arrayContains(values, array, key) {

   for(let i = 0; i < array.length; i++) {
      let haveValue = false;
      for(let j = 0; j < values.length; j++) {
        if(values[j] == array[i][key]) {
            haveValue = true;
        }
      }

      if(!haveValue) {
         return false;
      }
   }

   return true;
}