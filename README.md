# database-research-paper-impl
## Performance Evaluation

| Operation                       | Insert              | Pharmacy | Patient_Generic_Details_Table | Patient_Social_INS_Table | Patient_Health_INS_Table |
|---------------------------------|---------------------|----------|--------------------------------|---------------------------|--------------------------|
| No encryption, no log triggers  | Insert 10k records | 34 sec   | 35 sec                         | 35 sec                    | 32 sec                   |
| No encryption, with log triggers| Insert 10k records | -        | -                              | 32 sec                    | 35 sec                   |
| With encryption, no log triggers| Insert 10k records | -        | -                              | 32 sec                    | 32 sec                   |
| With encryption and log triggers| Insert 10k records | -        | -                              | 36 sec                    | 37 sec                   |
| Without decryption              | Retrieve 10k records| 0 sec  | 0 sec                          | 0 sec                     | 0 sec                    |
| With decryption                 | Retrieve 10k records| 0 sec  | 0 sec                          | 15 sec                    | 0 sec                    |

