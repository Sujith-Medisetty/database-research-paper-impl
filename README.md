# database-research-paper-impl
## Performance Evaluation

| Operation                       | Pharmacy | Patient_Generic_Details_Table | Patient_Social_INS_Table | Patient_Health_INS_Table |
|---------------------------------|----------|--------------------------------|---------------------------|--------------------------|
| No encryption, no log triggers  | 34 sec   | 35 sec                         | 35 sec                    | 32 sec                   |
| No encryption, with log triggers| -        | -                              | 32 sec                    | 35 sec                   |
| With encryption, no log triggers| -        | -                              | 32 sec                    | 32 sec                   |
| With encryption and log triggers| -        | -                              | 36 sec                    | 37 sec                   |
| Without decryption              | 0 sec    | 0 sec                          | 0 sec                     | 0 sec                    |
| With decryption                 | 0 sec    | 0 sec                          | 15 sec                    | 0 sec                    |
