       identification division.
       program-id. DataSplitAndCount.
       author. Ngoc Diep Nguyen.
       date-written. 03-April-2020.

       environment division.
       configuration section.

       input-output section.
       file-control.

           select data-file
               assign to "../../../data/validData.dat"
                   organization is line sequential.

           select sandl-file
               assign to "../../../data/sandl-record.dat"
                   organization is line sequential.
           
           select return-data
               assign to "../../../data/r-record.out"
                   organization is line sequential.

           select project2-data
               assign to "../../../data/project2-report.out"
                   organization is line sequential.
       data division.
       file section.

       fd data-file
           data record is input-rec
           record contains 36 characters.

       01 input-rec.
           05  in-trans-code           pic x.
           05  in-trans-amount         pic 9(05)v99.
           05  in-pay-type             pic xx.
           05  in-store-no             pic xx.
           05  in-invoice-number       pic x(9).           
           05  in-sku-code             pic x(15).

       fd sandl-file
           data record is sandl-rep
           record contains 36 characters.
       01 sandl-rep                    pic x(36).

       fd return-data
           data record is return-rec
           record contains 36 characters.
       01 return-rec                   pic x(36).
       
       fd project2-data
           data record is project2-rep
           record contains 105 characters.
       01 project2-rep                 pic x(105).
       
       working-storage section.

       01 team-title.
           05 filler                   pic x(07)
               value "GROUP-2".
           05 filler                   pic x(34)
               value spaces.
           05 filler                   pic x(05)
               value "Date:".
           05 filler                   pic x(01)
               value spaces.
           05 ws-date                  pic x9/99/99.
           05 filler                   pic x(09)
               value spaces.
           05 filler                   pic x(05)
               value "Time:".
           05 filler                   pic x(01)
               value spaces.
           05 ws-time                  pic x9/99/99.

       01 main-heading.
           05 filler                   pic x(23)
               value spaces.
           05 filler                   pic x(21)
               value "GROUP PROJECT - MFD-2".

       01 title-heading.
           05 filler                   pic x(17)
               value spaces.
           05 filler                   pic x(33)
               value "COUNTS AND CONTROL TOTALS REPORT".

       01 total-sandl-record.
           05 filler                   pic x(50)
               value "Total number of S&L records (combined): ".
           05 filler                   pic x(06)
               value spaces.
           05 op-total-sandl-record    pic zz9.

       01 total-sandl-amount.
           05 filler                   pic x(45)
               value "Total amount of S&L transactions: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-sandl-amount    pic $$$,$$9.99.

       01 total-s-record.
           05 filler                   pic x(50)
               value "Total number of S records: ".
           05 filler                   pic x(06)
               value spaces.
           05 op-total-s-record        pic zz9.

       01 total-l-record.
           05 filler                   pic x(50)
               value "Total number of L records: ".
           05 filler                   pic x(06)
               value spaces.
           05 op-total-l-record        pic zz9.

       01 total-s-amount.
           05 filler                   pic x(45)
               value "Total amount of S transactions: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-s-amount        pic $$$,$$9.99.

       01 total-l-amount.
           05 filler                   pic x(45)
               value "Total amount of L transactions: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-l-amount        pic $$$,$$9.99.


       01 total-store-01.
           05 filler                   pic x(45)
               value "Total transaction S&L amount of store 01: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-store-01        pic $$$,$$9.99.

       01 total-store-02.
           05 filler                   pic x(45)
               value "Total transaction S&L amount of store 02: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-store-02        pic $$$,$$9.99.

       01 total-store-03.
           05 filler                   pic x(45)
               value "Total transaction S&L amount of store 03: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-store-03        pic $$$,$$9.99.

       01 total-store-04.
           05 filler                   pic x(45)
               value "Total transaction S&L amount of store 04: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-store-04        pic $$$,$$9.99.

       01 total-store-05.
           05 filler                   pic x(45)
               value "Total transaction S&L amount of store 05: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-store-05        pic $$$,$$9.99.

       01 total-store-12.
           05 filler                   pic x(45)
               value "Total transaction S&L amount of store 12: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-store-12        pic $$$,$$9.99.

       01 cal-per-type1.
           05 filler                   pic x(50)
               value "% number of transactions in Type CA: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-percent-type1         pic Z9.99.

       01 cal-per-type2.
           05 filler                   pic x(50)
               value "% number of transactions in Type CR: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-percent-type2         pic z9.99.

       01 cal-per-type3.
           05 filler                   pic x(50)
               value "% number of transactions in Type DB: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-percent-type3         pic z9.99.

       01 total-r-record.
           05 filler                   pic x(50)
               value "Total number of R records: ".
           05 filler                   pic x(06)
               value spaces.
           05 op-total-r-record        pic zz9.

       01 total-r-amount.
           05 filler                   pic x(45)
               value "Total amount of R transactions: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-r-amount        pic $$$,$$9.99.

       01 total-r-store-01.
           05 filler                   pic x(45)
               value "Total transaction R amount of store 01: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-r-store-01      pic $$$,$$9.99.

       01 total-r-store-02.
           05 filler                   pic x(45)
               value "Total transaction R amount of store 02: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-r-store-02      pic $$$,$$9.99.

       01 total-r-store-03.
           05 filler                   pic x(45)
               value "Total transaction R amount of store 03: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-r-store-03      pic $$$,$$9.99.

       01 total-r-store-04.
           05 filler                   pic x(45)
               value "Total transaction R amount of store 04: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-r-store-04      pic $$$,$$9.99.

       01 total-r-store-05.
           05 filler                   pic x(45)
               value "Total transaction R amount of store 05: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-r-store-05      pic $$$,$$9.99.

       01 total-r-store-12.
           05 filler                   pic x(45)
               value "Total transaction R amount of store 12: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-r-store-12      pic $$$,$$9.99.

       01 total-r-rec-01.
           05 filler                   pic x(45)
               value "Total number of R record of store 01: ".
           05 filler                   pic x(08)
               value spaces.
           05 op-total-r-rec-01        pic zz9.

       01 total-r-rec-02.
           05 filler                   pic x(45)
               value "Total number of R record of store 02: ".
           05 filler                   pic x(08)
               value spaces.
           05 op-total-r-rec-02        pic zz9.

       01 total-r-rec-03.
           05 filler                   pic x(45)
               value "Total number of R record of store 03: ".
           05 filler                   pic x(08)
               value spaces.
           05 op-total-r-rec-03        pic zz9.

       01 total-r-rec-04.
           05 filler                   pic x(45)
               value "Total number of R record of store 04: ".
           05 filler                   pic x(08)
               value spaces.
           05 op-total-r-rec-04        pic zz9.

       01 total-r-rec-05.
           05 filler                   pic x(45)
               value "Total number of R record of store 05: ".
           05 filler                   pic x(08)
               value spaces.
           05 op-total-r-rec-05        pic zz9.

       01 total-r-rec-12.
           05 filler                   pic x(45)
               value "Total number of R record of store 12: ".
           05 filler                   pic x(08)
               value spaces.
           05 op-total-r-rec-12        pic zz9.

       01 total-grand-amount.
           05 filler                   pic x(40)
               value "Total Grand Amount: ".
           05 filler                   pic x(09)
               value spaces.
           05 op-total-grand-amount    pic $$$,$$9.99.

       01 ws-calc.
           05 ws-sandl-record          pic 999
               value 0.
           05 ws-sandl-amount          pic 9(5)v99.
           05 ws-s-record              pic 999
               value 0.
           05 ws-s-amount              pic 9(5)v99
               value 0.
           05 ws-l-record              pic 999
               value 0.
           05 ws-l-amount              pic 9(5)v99
               value 0.
           05 ws-s-store-1             pic 9(5)v99
               value 0.
           05 ws-s-store-2             pic 9(5)v99
               value 0.
           05 ws-s-store-3             pic 9(5)v99
               value 0.
           05 ws-s-store-4             pic 9(5)v99
               value 0.
           05 ws-s-store-5             pic 9(5)v99
               value 0.
           05 ws-s-store-12            pic 9(5)v99
               value 0.
           05 ws-s-type-1-count        pic 999
               value 0.
           05 ws-s-type-2-count        pic 999
               value 0.
           05 ws-s-type-3-count        pic 999
               value 0.
           05 ws-s-type-1              pic 99v99
               value 0.
           05 ws-s-type-2              pic 99v99
               value 0.
           05 ws-s-type-3              pic 99v99
               value 0.
           05 ws-r-record              pic 999
               value 0.
           05 ws-r-amount              pic 9(5)v99
               value 0.
           05 ws-r-store-1             pic 9(5)v99
               value 0.
           05 ws-r-store-2             pic 9(5)v99
               value 0.
           05 ws-r-store-3             pic 9(5)v99
               value 0.
           05 ws-r-store-4             pic 9(5)v99
               value 0.
           05 ws-r-store-5             pic 9(5)v99
               value 0.
           05 ws-r-store-12            pic 9(5)v99
               value 0.
           05 ws-r-record-01           pic 999
               value 0.
           05 ws-r-record-02           pic 999
               value 0.
           05 ws-r-record-03           pic 999
               value 0.
           05 ws-r-record-04           pic 999
               value 0.
           05 ws-r-record-05           pic 999
               value 0.
           05 ws-r-record-12           pic 999
               value 0.
           05 ws-grand-total           pic 9(5)v99
               value 0.


       01 flags.
           05 ws-eof-flag              pic x value 'N'.

         
       procedure division.

       000-Main.

           open input data-file.

           open output return-data,
                       sandl-file,
                       project2-data.

           accept ws-date              from date.
           accept ws-time              from time.

           read data-file
               at end
                 move 'N'              to ws-eof-flag.
           
           perform 100-project2-report-heading.

           perform 200-data-process
               until ws-eof-flag = 'Y'.

           perform 400-print-footer.
           
           close data-file,
                 return-data,
                 sandl-file,
                 project2-data.
           
           display "End of Data Split and Count Program."
           display "Press Enter to continue.."

           accept return-code.

           goback.

       100-project2-report-heading.
           write project2-rep          from team-title.
           write project2-rep          from main-heading
               after advancing 1 line.
           write project2-rep          from title-heading
               after advancing 1 line.

       200-data-process.

           perform 300-edit-process.
      
           read data-file
               at end
                 move 'Y'              to ws-eof-flag.

       300-edit-process.

           if in-trans-code = "S" or in-trans-code = "L" then
               add 1                   to ws-sandl-record
               add in-trans-amount     to ws-sandl-amount
               perform 310-sandl-process
           else
               add 1                   to ws-r-record
               add in-trans-amount     to ws-r-amount
               perform 320-r-process
           end-if.
           
           compute ws-grand-total = ws-sandl-amount - ws-r-amount.

       310-sandl-process.

           if in-trans-code = "S" then
               add 1                   to ws-s-record
               add in-trans-amount     to ws-s-amount
           else
               add 1                   to ws-l-record
               add in-trans-amount     to ws-l-amount
           end-if.

           if in-store-no = "01" then
               add in-trans-amount     to ws-s-store-1
           else if in-store-no = "02" then
               add in-trans-amount     to ws-s-store-2
           else if in-store-no = "03" then
               add in-trans-amount     to ws-s-store-3
           else if in-store-no = "04" then
               add in-trans-amount     to ws-s-store-4
           else if in-store-no = "05" then
               add in-trans-amount     to ws-s-store-5
           else
               add in-trans-amount to ws-s-store-12
           end-if
           end-if
           end-if
           end-if
           end-if.

           if in-pay-type = "CA" then
               add 1                   to ws-s-type-1-count
           else if in-pay-type = "CR" then
               add 1                   to ws-s-type-2-count
           else
               add 1                   to ws-s-type-3-count
           end-if
           end-if.

           compute ws-s-type-1 rounded =
                ( ws-s-type-1-count / ws-sandl-record ) * 100.
           compute ws-s-type-2 rounded =
                ( ws-s-type-2-count / ws-sandl-record ) * 100.
           compute ws-s-type-3 rounded =
                ( ws-s-type-3-count / ws-sandl-record ) * 100.

           write sandl-rep             from input-rec.
       320-r-process.


           if in-store-no = "01" then
               add 1                   to ws-r-record-01
               add in-trans-amount     to ws-r-store-1
           else if in-store-no = "02" then
               add 1                   to ws-r-record-02
               add in-trans-amount     to ws-r-store-2
           else if in-store-no = "03" then
               add 1                   to ws-r-record-03
               add in-trans-amount     to ws-r-store-3
           else if in-store-no = "04" then
               add 1                   to ws-r-record-04
               add in-trans-amount     to ws-r-store-4
           else if in-store-no = "05" then
               add 1                   to ws-r-record-05
               add in-trans-amount     to ws-r-store-5
           else
               add 1                   to ws-r-record-12
               add in-trans-amount     to ws-r-store-12
           end-if
           end-if
           end-if
           end-if
           end-if.
           write return-rec            from input-rec.

       400-print-footer.

           move ws-sandl-record        to op-total-sandl-record.
           move ws-sandl-amount        to op-total-sandl-amount.
           move ws-s-record            to op-total-s-record.
           move ws-s-amount            to op-total-s-amount.
           move ws-l-record            to op-total-l-record.
           move ws-l-amount            to op-total-l-amount.
           move ws-s-store-1           to op-total-store-01.
           move ws-s-store-2           to op-total-store-02.
           move ws-s-store-3           to op-total-store-03.
           move ws-s-store-4           to op-total-store-04.
           move ws-s-store-5           to op-total-store-05.
           move ws-s-store-12          to op-total-store-12.
           move ws-r-record            to op-total-r-record.
           move ws-r-amount            to op-total-r-amount.
           move ws-r-store-1           to op-total-r-store-01.
           move ws-r-store-2           to op-total-r-store-02.
           move ws-r-store-3           to op-total-r-store-03.
           move ws-r-store-4           to op-total-r-store-04.
           move ws-r-store-5           to op-total-r-store-05.
           move ws-r-store-12          to op-total-r-store-12.
           move ws-r-record-01         to op-total-r-rec-01.
           move ws-r-record-02         to op-total-r-rec-02.
           move ws-r-record-03         to op-total-r-rec-03.
           move ws-r-record-04         to op-total-r-rec-04.
           move ws-r-record-05         to op-total-r-rec-05.
           move ws-r-record-12         to op-total-r-rec-12.

           move ws-s-type-1            to op-percent-type1.
           move ws-s-type-2            to op-percent-type2.
           move ws-s-type-3            to op-percent-type3.
           move ws-grand-total         to op-total-grand-amount.
           move spaces                 to project2-rep.
           write project2-rep          from total-sandl-amount
               after advancing 2 lines.
           write project2-rep          from total-sandl-record.
           write project2-rep          from total-s-record.
           write project2-rep          from total-s-amount.
           write project2-rep          from total-l-record.
           write project2-rep          from total-l-amount.
           write project2-rep          from total-store-01
               after advancing 2 lines.
           write project2-rep          from total-store-02.
           write project2-rep          from total-store-03.
           write project2-rep          from total-store-04.
           write project2-rep          from total-store-05.
           write project2-rep          from total-store-12.
           write project2-rep          from cal-per-type1
               after advancing 2 lines.
           write project2-rep          from cal-per-type2.
           write project2-rep          from cal-per-type3.
           write project2-rep          from total-r-record
               after advancing 2 lines.
           write project2-rep          from total-r-amount.
           write project2-rep          from total-r-store-01
               after advancing 2 lines.
           write project2-rep          from total-r-store-02.
           write project2-rep          from total-r-store-03.
           write project2-rep          from total-r-store-04.
           write project2-rep          from total-r-store-05.
           write project2-rep          from total-r-store-12.
           write project2-rep          from total-r-rec-01
               after advancing 2 lines.
           write project2-rep          from total-r-rec-02.
           write project2-rep          from total-r-rec-03.
           write project2-rep          from total-r-rec-04.
           write project2-rep          from total-r-rec-05.
           write project2-rep          from total-r-rec-12.
           write project2-rep          from total-grand-amount
           after advancing 2 lines.


       end program DataSplitAndCount.
