public class NS_BitSet {
 public Map < String, Integer > alphaNumCharCodes {
  get;
  set;
 }
 public Map < String, Integer > base64CharCodes {
  get;
  set;
 }
 
 public NS_BitSet() {
  LoadCharCodes();
 }
 
 //Method loads the character codes for all letters
 public void LoadCharCodes() {
  alphaNumCharCodes = new Map < String, Integer > {
   'A' => 65,
   'B' => 66,
   'C' => 67,
   'D' => 68,
   'E' => 69,
   'F' => 70,
   'G' => 71,
   'H' => 72,
   'I' => 73,
   'J' => 74,
   'K' => 75,
   'L' => 76,
   'M' => 77,
   'N' => 78,
   'O' => 79,
   'P' => 80,
   'Q' => 81,
   'R' => 82,
   'S' => 83,
   'T' => 84,
   'U' => 85,
   'V' => 86,
   'W' => 87,
   'X' => 88,
   'Y' => 89,
   'Z' => 90
  };
  base64CharCodes = new Map < String, Integer > ();
  //all lower cases
  Set < String > pUpperCase = alphaNumCharCodes.keySet();
  for (String pKey: pUpperCase) {
   //the difference between upper case and lower case is 32
   alphaNumCharCodes.put(pKey.toLowerCase(), alphaNumCharCodes.get(pKey) + 32);
   //Base 64 alpha starts from 0 (The ascii charcodes started from 65)
   base64CharCodes.put(pKey, alphaNumCharCodes.get(pKey) - 65);
   base64CharCodes.put(pKey.toLowerCase(), alphaNumCharCodes.get(pKey) - (65) + 26);
  }
  //numerics
  for (Integer i = 0; i <= 9; i++) {
   alphaNumCharCodes.put(string.valueOf(i), i + 48);
   //base 64 numeric starts from 52
   base64CharCodes.put(string.valueOf(i), i + 52);
  }
 }
 
 public List < Integer > testBits(String pValidFor, List < Integer > nList) {
  List < Integer > results = new List < Integer > ();
  List < Integer > pBytes = new List < Integer > ();
  Integer bytesBeingUsed = (pValidFor.length() * 6) / 8;
  Integer pFullValue = 0;
  if (bytesBeingUsed <= 1)
   return results;
  for (Integer i = 0; i < pValidFor.length(); i++) {
   pBytes.Add((base64CharCodes.get((pValidFor.Substring(i, i + 1)))));
  }
  for (Integer i = 0; i < pBytes.size(); i++) {
   Integer pShiftAmount = (pBytes.size() - (i + 1)) * 6; /*used to shift by a factor 6 bits to get the value*/
   pFullValue = pFullValue + (pBytes[i] << (pShiftAmount));
  }
 
  Integer bit;
  Integer targetOctet;
  Integer shiftBits;
  Integer tBitVal;
  Integer n;
  Integer nListSize = nList.size();
  for (Integer i = 0; i < nListSize; i++) {
   n = nList[i];
   bit = 7 - (Math.mod(n, 8));
   targetOctet = (bytesBeingUsed - 1) - (n >> bytesBeingUsed);
   shiftBits = (targetOctet * 8) + bit;
   tBitVal = ((Integer)(2 << (shiftBits - 1)) & pFullValue) >> shiftBits;
   if (tBitVal == 1)
    results.add(n);
  }
  return results;
 }
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    
    private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    
    
    public static List<NS_PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<NS_PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<NS_PicklistEntryWrapper>.class);
    }
    
        
}