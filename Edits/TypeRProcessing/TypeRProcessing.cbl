       identification division.
       program-id. TypeRProcessing.
       author. Jimmy Paul.
       date-written. 08-April-2020.

       environment division.
       configuration section.

       input-output section.
       file-control.
           select data-file
               assign to "../../../data/r-record.out"
                   organization is line sequential.
           select output-file
               assign to "../../../data/return-report.out"
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
           05 filler                   pic x(04)
               value "OWED".
           05 filler                   pic x(01)
               value spaces.

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
           05 op-tax-owed              pic $$,$$9.99.

       01 total-r-record.
           05 filler                   pic x(39)
               value "Total number of R records: ".
           05 filler                   pic x(14)
               value spaces.
           05 op-total-r-record        pic zz9.

       01 total-r-amount.
           05 filler                   pic x(45)
               value "Total number of R amount: ".
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
           05 filler                       pic x(45)
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

       01 total-tax-owed-line.
           05 filler                   pic x(16)
               value "Total Tax Owed:".
           05 filler                   pic x(34)
               value spaces.
           05 op-total-tax-owed        pic $$,$$9.99.

       01 ws-counters.
           05 ws-line-counter          pic 99.
           05 ws-page-counter          pic 99 value 1.

       01 flags.
           05 ws-eof-flag              pic x value 'N'.

       01 ws-calc.
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
           05 ws-tax-owed              pic 9(05)v99
               value 0.
           05 ws-total-tax-owed        pic 9(05)v99
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

           display "End of Type R Processing Program."
           display "Press Enter to continue..".

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
           compute ws-tax-owed rounded = in-trans-amount * 13/100.
           add ws-tax-owed             to ws-total-tax-owed.

           perform 400-r-records.

           move in-trans-code          to op-tr-code.
           move in-trans-amount        to op-tr-amount.
           move in-pay-type            to op-pay-type.
           move in-store-no            to op-store-no.
           move in-invoice-number      to op-inv-number.
           move in-sku-code            to op-sku-code
           move ws-tax-owed            to op-tax-owed.
           
           write output-line           from rec-line
               after advancing 1 line.

           read data-file
               at end
                   move 'Y'            to ws-eof-flag.
       400-r-records.
           add 1                       to ws-r-record.
           add in-trans-amount         to ws-r-amount.

           if in-store-no = "01" then
               add 1                   to ws-r-record-01
               add in-trans-amount     to ws-r-store-1
           else if in-store-no = "02"  then
               add 1                   to ws-r-record-02
               add in-trans-amount     to ws-r-store-2
           else if in-store-no = "03"  then
               add 1                   to ws-r-record-03
               add in-trans-amount     to ws-r-store-3
           else if in-store-no = "04" then
               add 1                   to ws-r-record-04
               add in-trans-amount     to ws-r-store-4
           else if in-store-no = "05"  then
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

       500-print-footer.

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
           move ws-total-tax-owed      to op-total-tax-owed

           write output-line           from total-r-record
               after advancing 2 lines.
           write output-line           from total-r-amount.

           write output-line           from total-r-store-01
               after advancing 2 lines.
           write output-line           from total-r-store-02.
           write output-line           from total-r-store-03.
           write output-line           from total-r-store-04.
           write output-line           from total-r-store-05.
           write output-line           from total-r-store-12.

           write output-line           from total-r-rec-01
               after advancing 2 lines.
           write output-line           from total-r-rec-02.
           write output-line           from total-r-rec-03.
           write output-line           from total-r-rec-04.
           write output-line           from total-r-rec-05.
           write output-line           from total-r-rec-12.

           write output-line           from total-tax-owed-line
               after advancing 2 lines.

       end program TypeRProcessing.
