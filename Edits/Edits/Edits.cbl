       identification division.
       program-id. Edits.
       author. Muhammad Abbas.
       date-written. 30-March-2020.

       environment division.
       configuration section.

       input-output section.
       file-control.
           select data-file
               assign to "../../../data/project3.dat"
                   organization is line sequential.

           select valid-file
               assign to "../../../data/validData.dat"
                   organization is line sequential.
           
           select invalid-data
               assign to "../../../data/invalidData.out"
                   organization is line sequential.

           select error-data
               assign to "../../../data/error-report.out"
                   organization is line sequential.
       data division.
       file section.

       fd data-file
           data record is input-rec
           record contains 36 characters.

       01 input-rec.
           05  in-trans-code           pic x.
               88 trans-code-valid
                  value 'S','R','L'.
           05  in-trans-amount         pic 9(05)v99.
           05  in-pay-type             pic xx.
               88 payment-type-valid
                  value 'CA','CR','DB'.
           05  in-store-no             pic xx.
               88 store-number-valid
                   value '01','02','03','04','05','12'.
           05 in-invoice-number.           
               10 invoice-char         pic xx.
               10 invoice-char-r redefines
                  invoice-char.
                   15 invoice-fir-char pic x.
                    88 invoice-fir-valid
                        value 'A','B','C','D','E'.
                  15 invoice-sec-char  pic x.
                    88 invoice-sec-valid
                        value 'A','B','C','D','E'.
               10 invoice-symbol       pic x.
                   88 invoice-sym-valid
                       value '-'.
               10 invoice-no           pic 9(06).
           05  in-sku-code             pic x(15).

       fd valid-file
           data record is valid-rep
           record contains 36 characters.
       01 valid-rep                    pic x(36).

       fd invalid-data
           data record is invalid-rec
           record contains 36 characters.
       01 invalid-rec                  pic x(36).
       
       fd error-data
           data record is error-rep
           record contains 78 characters.
       01 error-rep                    pic x(78).
       
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
               value "GROUP PROJECT - MFD-1".

       01 title-heading.
           05 filler                   pic x(27)
               value spaces.
           05 filler                   pic x(12)
               value "ERROR REPORT".

       01 error-heading.
           10 filler                   pic x(14)
               value "INVOICE NUMBER".
           10 filler                   pic x(10)
               value spaces.
           10 filler                   pic x(17)
               value "ERROR DESCRIPTION".
           10 filler                   pic x(15)
               value spaces.
           10 filler                   pic x(22)
               value "NO OF ERRORS IN RECORD".

       01 error-heading-details.
           05 op-invoice-number        pic x(9).
           05 filler                   pic x(15)
               value spaces.
           05 op-error-description     pic x(26).
           05 filler                   pic x(14)
               value spaces.
           05 op-error-counter         pic z9.

       01 error-types.
           05 err-trans-code           pic x(24)
               value "Invalid Transaction code".
           05 err-trans-amount         pic x(26)
               value "Invalid Transaction amount".
           05 err-pay-type             pic x(20)
               value "Invalid Payment type".
           05 err-store-no             pic x(20)
               value "Invalid Store Number".
           05 err-invoice-no           pic x(22)
               value "Invalid Invoice Number".
           05 err-sku-code             pic x(16)
               value "Invalid SKU Code".

       01 constants.
           05 cnst-invoice-min-value   pic 9(06)
               value 100000.
           05 cnst-invoice-max-value   pic 9(06)
               value 900000.

       
       01 total-record-footer.
           05 filler                   pic x(15)
               value "Total Records =".
           05 filler                   pic x(04)
               value spaces.
           05 op-total-counter         pic zz9.

       01 valid-record-footer.
           05 filler                   pic x(15)
               value "Valid Records =".
           05 filler                   pic x(04)
               value spaces.
           05 op-valid-rec-counter     pic zz9.

       01 invalid-record-footer.
           05 filler                   pic x(17)
               value "Invalid Records =".
           05 filler                   pic x(02)
               value spaces.
           05 op-invalid-rec-counter   pic zz9.

       01 ws-calc-variable.
           05 ws-description           pic x(26).

       01 flags.
           05 ws-eof-flag              pic x value 'N'.

       01 counters.
          05 ws-total-counter          pic 9(03) value 0.
          05 ws-error-counter          pic 9(03) value 0.
          05 ws-valid-counter          pic 9(03) value 0.
          05 ws-invalid-counter        pic 9(03) value 0.
         
       procedure division.

       000-Main.

           open input data-file.

           open output invalid-data,
                       valid-file,
                       error-data.

           accept ws-date              from date.
           accept ws-time              from time.

           read data-file
               at end
                 move 'N'              to ws-eof-flag.
           
           perform 100-error-report-heading.

           perform 200-data-process
               until ws-eof-flag = 'Y'.

           perform 400-print-footer.
           
           close data-file,
                 invalid-data,
                 valid-file,
                 error-data.
           
           display "End of Edits Program."
           display "Press Enter to continue.."

           accept return-code.

           goback.

       100-error-report-heading.
           write error-rep             from team-title.
           write error-rep             from main-heading
               after advancing 1 line.
           write error-rep             from title-heading
               after advancing 1 line
           write error-rep             from error-heading
               after advancing 2 lines.
           write error-rep             from error-heading-details.

       200-data-process.

           add 1                       to ws-total-counter.
           move 0                      to ws-error-counter.
           move spaces                 to ws-description.

           perform 300-edit-process.
      
           read data-file
               at end
                 move 'Y'              to ws-eof-flag.


       300-edit-process.

           if not trans-code-valid
               add 1                   to ws-error-counter
               move err-trans-code     to ws-description
           end-if.

           if in-trans-amount is not numeric
               add 1                   to ws-error-counter
               move err-trans-amount   to ws-description
           end-if.

           if not payment-type-valid
               add 1                   to ws-error-counter
               move err-pay-type       to ws-description
           end-if.

           if not store-number-valid
               add 1                   to ws-error-counter
               move err-store-no       to ws-description
           end-if.

           if not invoice-fir-valid or not invoice-sec-valid
               add 1                   to ws-error-counter
               move err-invoice-no     to ws-description
           end-if.

           if invoice-fir-char
               is equal                to invoice-sec-char
               add 1                   to ws-error-counter
               move err-invoice-no     to ws-description
           end-if.

           if invoice-no is not numeric
               add 1                   to ws-error-counter
               move err-invoice-no     to ws-description
           end-if.

           if not invoice-sym-valid
               add 1                   to ws-error-counter
               move err-invoice-no     to ws-description
           end-if.

           if invoice-no > cnst-invoice-max-value or
              invoice-no < cnst-invoice-min-value
               add 1                   to ws-error-counter
               move err-invoice-no     to ws-description
           end-if.

           if in-sku-code is equal to spaces
               add 1                   to ws-error-counter
               move err-sku-code       to ws-description
           end-if.
       
           if ws-error-counter = 0
               write valid-rep         from input-rec
               add 1                   to ws-valid-counter
           else
               add 1                   to ws-invalid-counter
               move in-invoice-number  to op-invoice-number
               move ws-description     to op-error-description
               move ws-error-counter   to op-error-counter

               write invalid-rec       from input-rec
               write error-rep         from error-heading-details
           end-if.

       400-print-footer.

           move ws-total-counter       to op-total-counter.
           move ws-valid-counter       to op-valid-rec-counter.
           move ws-invalid-counter     to op-invalid-rec-counter.
      
           move spaces                 to error-rep.
           write error-rep             from total-record-footer
               after advancing 2 lines.
           write error-rep             from valid-record-footer.
           write error-rep             from invalid-record-footer.

       end program Edits.
