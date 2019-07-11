/*
Description  : This test class is to test the functionality of dependent picklists
Developer    : Accenture Solutions
Date         : 20-06-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Arjun Ghosh    17-07-2018     Unit testing methods
*/
@isTest(SeeAllData=false)
public class NS_BitSetTest {
    @isTest
     static void testRun(){
        NS_BitSet obj = new NS_BitSet();
         obj.LoadCharCodes();
         String validFor=NS_StaticVariablesUtility.testvalidFor;
         List < Integer > nList=new List<Integer>();
         nList.add(0);nList.add(1);nList.add(2);nList.add(3);
         nList.add(4);nList.add(5);nList.add(6);nList.add(7);
         List < Integer > expectedList=new List<Integer>();
         expectedList.add(1);expectedList.add(2);expectedList.add(5);
         integer val= 36;
         NS_BitSet.decimalToBinary(val);
         NS_BitSet.base64ToBits(validFor);
         System.assertEquals(expectedList, obj.testBits(validFor, nList));
       }
}