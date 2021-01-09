       identification division.
       program-id. SandLProcessing.
       author. Muhammad Abbas.
       date-written. 06-April-2020.

       environment division.
       configuration section.

       input-output section.
       file-control.
           select data-file
               assign to "../../../data/sandl-record.dat"
                   organization is line sequential.
           
           select output-file
               assign to "../../../data/sales-report.out"
                  organization is line sequential.

       data division.
       file section.

       fd data-file
           data record is input-rec
           record contains 36 characters.

       01 input-rec.
           05 in-trans-code            pic x.
           05 in-trans-amount          pic 9(05)v99.
           05 in-pay-type              pic xx.
           05 in-store-no              pic xx.
           05 in-invoice-number        pic x(09).
           05 in-sku-code              pic x(15).

       fd output-file
           data record is output-line
           record contains 122 characters.
       01 output-line                  pic x(122).

       working-storage section.

       01 team-title.
           05 filler                   pic x(07)
               value "GROUP-2".
           05 filler                   pic x(78)
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
           05 filler                   pic x(43)
               value spaces.
           05 filler                   pic x(21)
               value "GROUP PROJECT - MFD-2".
           05 filler                   pic x(58)
               value spaces.

       01 title-heading.
           05 filler                   pic x(37)
               value spaces.
           05 filler                   pic x(33)
               value "COUNTS AND CONTROL TOTALS REPORT".
           05 filler                   pic x(42)
               value spaces.
           05 filler                   pic x(08)
               value "Page No:".
           05 op-page-counter          pic z9
               value 1.

       01 report-heading-line1.
           05 filler                   pic x(17)
               value "INPUT TRANSACTION".
           05 filler                   pic x(06)
               value spaces.
           05 filler                   pic x(17)
               value "INPUT TRANSACTION".
           05 filler                   pic x(10)
               value spaces.
           05 filler                   pic x(08)
               value "PAYMENT".
           05 filler                   pic x(09)
               value spaces.
           05 filler                   pic x(05)
               value "STORE".
           05 filler                   pic x(11)
               value spaces.
           05 filler                   pic x(07)
               value "INVOICE".
           05 filler                   pic x(09)
               value spaces.
           05 filler                   pic x(03)
               value "SKU".
           05 filler                   pic x(16)
               value spaces.
           05 filler                   pic x(03)
               value "TAX".
           05 filler                   pic x(01)
               value spaces.

       01 report-heading-line2.
           05 filler                   pic x(06)
                 value spaces.
           05 filler                   pic x(04)
               value "CODE".
           05 filler                   pic x(19)
               value spaces.
           05 filler                   pic x(06)
               value "AMOUNT".
           05 filler                   pic x(17)
               value spaces.
           05 filler                   pic x(04)
               value "TYPE".
           05 filler                   pic x(11)
               value spaces.
           05 filler                   pic x(06)
               value "NUMBER".
           05 filler                   pic x(10)
               value spaces.
           05 filler                   pic x(06)
               value "NUMBER".
           05 filler                   pic x(10)
               value spaces.
           05 filler                   pic x(04)
               value "CODE".
           05 filler                   pic x(14)
               value spaces.
           05 filler                   pic x(05)
               value "OWING".

       01 rec-line.
           05 filler                   pic x(07)
                 value spaces.
           05 op-tr-code               pic x.
           05 filler                   pic x(18)
                 value spaces.
           05 op-tr-amount             pic zz,zz9.99.
           05 filler                   pic x(18)
                 value spaces.
           05 op-pay-type              pic xx.
           05 filler                   pic x(14)
                 value spaces.
           05 op-store-no              pic 99.
           05 filler                   pic x(10)
                 value spaces.
           05 op-inv-number            pic x(09).
           05 filler                   pic x(06)
                 value spaces.
           05 op-sku-code              pic x(15).
           05 filler                   pic x(02)
                 value spaces.
           05 op-tax-owing             pic $$,$$9.99.

       01 total-sandl-record.
           05 filler                   pic x(50)
               value "Total number of S&L records (combined): ".
           05 filler                   pic x(06)
               value spaces.
           05 op-total-sandl-record    pic zz9.

       01 total-sandl-amount.
           05 filler                   pic x(45)
               value "Total number of S&L amount: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-sandl-amount    pic $$$,$$9.99.

       01 total-s-record.
           05 filler                   pic x(50)
               value "Total number of S records: ".
           05 filler                   pic x(06)
               value spaces.
           05 op-total-s-record        pic zz9.

       01 total-s-amount.
           05 filler                   pic x(45)
               value "Total number of S amount: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-s-amount        pic $$$,$$9.99.

       01 total-l-record.
           05 filler                   pic x(50)
               value "Total number of L records: ".
           05 filler                   pic x(06)
               value spaces.
           05 op-total-l-record        pic zz9.
       
       01 total-l-amount.
           05 filler                   pic x(45)
               value "Total number of L amount: ".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-l-amount        pic $$$,$$9.99.

       01 cal-type1-quantity.
           05 filler                   pic x(37)
               value "Total number of Type CA transactions: ".
           05 filler                   pic x(17)
               value spaces.
           05 op-type1-total           pic Z9.99.

       01 cal-type2-quantity.
           05 filler                   pic x(37)
               value "Total number of Type CR transactions: ".
           05 filler                   pic x(17)
               value spaces.
           05 op-type2-total           pic Z9.99.

       01 cal-type3-quantity.
           05 filler                   pic x(37)
               value "Total number of Type DB transactions: ".
           05 filler                   pic x(17)
               value spaces.
           05 op-type3-total           pic Z9.99.


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

       01 total-tax-owing-line.
           05 filler                   pic x(16)
               value "Total Tax Owing:".
           05 filler                   pic x(34)
               value spaces.
           05 op-total-tax-owing       pic $z,zz9.99.

       01 min-store-amount.
           05 filler                   pic x(32)
               value "Store Lowest Transaction Amount: ".
           05 filler                   pic x(18)
               value spaces.
           05 op-st-min-amount         pic $$,$$9.99.

       01 max-store-amount.
           05 filler                   pic x(33)
               value "Store Highest Transaction Amount: ".
           05 filler                   pic x(17)
               value spaces.
           05 op-st-max-amount         pic $$,$$9.99.

       01 ws-counters.
           05 ws-line-counter          pic 99.
           05 ws-page-counter          pic 99 value 1.

       01 flags.
           05 ws-eof-flag              pic x value 'N'.

       01 ws-calc.
           05 ws-tax-owing             pic 9(05)v99 value 0.
           05 ws-total-tax             pic 9(05)v99 value 0.
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
           05 ws-st1-amount            pic 9(06)v99
               value 0.
           05 ws-st2-amount            pic 9(06)v99
               value 0.
           05 ws-st3-amount            pic 9(06)v99
               value 0.
           05 ws-st4-amount            pic 9(06)v99
               value 0.
           05 ws-st5-amount            pic 9(06)v99
               value 0.
           05 ws-st12-amount           pic 9(06)v99
               value 0.
           05 ws-st-min-amount         pic 9(06)v99
               value 1.
           05 ws-st-max-amount         pic 9(06)v99
               value 1.
           05 ws-min-tmp-amount        pic 9(06)v99
               value 0.
           05 ws-max-tmp-amount        pic 9(06)v99
               value 0.
          
           
       procedure division.
       000-Main.

           open input data-file.
           open output output-file.

           accept ws-date              from date.
           accept ws-time              from time.

           read data-file
               at end
                  move 'Y'             to ws-eof-flag.
           
           perform 100-report-heading.


           perform 200-page-divide
               until ws-eof-flag = 'Y'.

           perform 500-print-footer.
      
           close data-file, output-file.
           
           display "End of S and L Processing Program."
           display "Press Enter to continue.."

           accept return-code.

           goback.

       100-report-heading.
           write output-line           from team-title.
           write output-line           from main-heading.

       200-page-divide.
           write output-line           from title-heading
               after advancing 2 lines.
           write output-line           from report-heading-line1
               after advancing 2 lines.
           write output-line           from report-heading-line2.

           perform 300-process-records
           
               varying ws-line-counter from 1 by 1
                   until ws-line-counter > 20
                       or ws-eof-flag = 'Y'.
           add 1                       to ws-page-counter.
           move ws-page-counter        to op-page-counter.
           
       300-process-records.
           compute ws-tax-owing rounded = in-trans-amount * 13/100.
           add ws-tax-owing            to ws-total-tax.

           perform 400-sandl-records.

           move in-trans-code          to op-tr-code.
           move in-trans-amount        to op-tr-amount.
           move in-pay-type            to op-pay-type.
           move in-store-no            to op-store-no.
           move in-invoice-number      to op-inv-number.
           move in-sku-code            to op-sku-code
           move ws-tax-owing           to op-tax-owing.
           
           write output-line           from rec-line
               after advancing 1 line.

           read data-file
               at end
                   move 'Y'            to ws-eof-flag.

       400-sandl-records.
           add 1                       to ws-sandl-record
           add in-trans-amount         to ws-sandl-amount
           perform 410-sandl-process.
           

       410-sandl-process.
           if in-trans-code = "S" then
               add 1                   to ws-s-record
               add in-trans-amount     to ws-s-amount
           else
               add 1                   to ws-l-record
               add in-trans-amount     to ws-l-amount
           end-if.

           if in-store-no = "01" then
               move in-trans-amount    to ws-st1-amount
           else if in-store-no = "02"  then
               move in-trans-amount    to ws-st2-amount
           else if in-store-no = "03"  then
               move in-trans-amount    to ws-st3-amount
           else if in-store-no = "04"  then
               move in-trans-amount    to ws-st4-amount
           else if in-store-no = "05"  then
               move in-trans-amount    to ws-st5-amount
           else
               move in-trans-amount    to ws-st12-amount
           end-if
           end-if
           end-if
           end-if
           end-if.
      
           if ws-st1-amount is greater than ws-max-tmp-amount
               move ws-st1-amount      to ws-max-tmp-amount
           end-if.

           if ws-st2-amount is greater than ws-max-tmp-amount
               move ws-st2-amount      to ws-max-tmp-amount
           end-if.

           if ws-st3-amount is greater than ws-max-tmp-amount
               move ws-st3-amount      to ws-max-tmp-amount
           end-if.

           if ws-st4-amount is greater than ws-max-tmp-amount
               move ws-st4-amount      to ws-max-tmp-amount
           end-if.

           if ws-st5-amount is greater than ws-max-tmp-amount
               move ws-st5-amount      to ws-max-tmp-amount
           end-if.

           if ws-st12-amount is greater than ws-max-tmp-amount
               move ws-st12-amount     to ws-max-tmp-amount
           end-if.

           move ws-max-tmp-amount      to ws-st-max-amount.

           move ws-st1-amount          to ws-min-tmp-amount.

           if ws-st2-amount is less than ws-min-tmp-amount
               move ws-st2-amount      to ws-min-tmp-amount
           end-if.

           if ws-st3-amount is less than ws-min-tmp-amount
               move ws-st3-amount      to ws-min-tmp-amount
           end-if.

           if ws-st4-amount is less than ws-min-tmp-amount
               move ws-st4-amount      to ws-min-tmp-amount
           end-if.
           
           if ws-st5-amount is less than ws-min-tmp-amount
               move ws-st5-amount      to ws-min-tmp-amount
           end-if.

           if ws-st12-amount is less than ws-min-tmp-amount
               move ws-st12-amount      to ws-min-tmp-amount
           end-if.
      
           move ws-min-tmp-amount      to ws-st-min-amount.

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

       500-print-footer.
           move ws-sandl-record        to op-total-sandl-record.
           move ws-sandl-amount        to op-total-sandl-amount.
           move ws-s-record            to op-total-s-record.
           move ws-s-amount            to op-total-s-amount.
           move ws-l-record            to op-total-l-record.
           move ws-l-amount            to op-total-l-amount.
           move ws-s-type-1            to op-percent-type1.
           move ws-s-type-2            to op-percent-type2.
           move ws-s-type-3            to op-percent-type3.
           move ws-s-type-1-count      to op-type1-total.
           move ws-s-type-2-count      to op-type2-total.
           move ws-s-type-3-count      to op-type3-total.
           move ws-s-type-1            to op-percent-type1.
           move ws-s-type-2            to op-percent-type2.
           move ws-s-type-3            to op-percent-type3.
           move ws-total-tax           to op-total-tax-owing.
           move ws-st-max-amount       to op-st-max-amount.
           move ws-st-min-amount       to op-st-min-amount.
           

           write output-line           from total-sandl-amount
               after advancing 2 lines.
           write output-line           from total-sandl-record.

           write output-line           from total-s-record
               after advancing 2 lines.
           write output-line           from total-s-amount.

           write output-line           from total-l-record
               after advancing 2 lines.
           write output-line           from total-l-amount.
           

           move spaces                 to output-line.
           write output-line           from cal-type1-quantity
               after advancing 2 lines.
           write output-line           from cal-type2-quantity.
           write output-line           from cal-type3-quantity

           move spaces                 to output-line.
      
           write output-line           from cal-per-type1
               after advancing 2 lines.
           write output-line           from cal-per-type2.
           write output-line           from cal-per-type3.

           move spaces                 to output-line.
           write output-line           from total-tax-owing-line
               after advancing 2 lines.

           move spaces                 to output-line.
           write output-line           from min-store-amount
               after advancing 2 lines.
           write output-line           from max-store-amount.
       
       end program SandLProcessing.
