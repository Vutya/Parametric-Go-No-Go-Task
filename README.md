# Parametric-Go-No-Go-Task
Psychtoolbox code for Paramtric Go/No-Go Task (PGNG task) from (Langenecker et al., 2007)

# Purpose of the experiment. What does it do? How to interpret the final output?
This is a Parametric Go/No-Go task - modified version of more traditional Go/No-Go task, but without some of the limitations and psychometrically well-characterized. It introduces 3 levels of the task. Level 1 has only 3 target letters (i.e., Go-trials). Level 2 has 2 target letters, but one cannot Go for them if they are repeated (e.g., 2 letters "x" in a row, the second one is No-Go trial). Level 3 is the same as level 2, but with 3 target letters instead of 2. 
Level 2 and 3 measures from the PGNG were intended to assess more complex executive (CE) functioning skills and context-based inhibition.

On each level PGNG task measures (1) sustained attention and set maintenance (PCTT - percentage correct target trials), (2) simple processing speed (complex for other levels) (RTT - Reaction time to targets), and (3) response inhibition (PCIT - percentage correct inhibitory trials).

Level 1: PCTT, RTT
Level 2: PCTT, RTT, PCIT
Level 3: PCTT, RTT, PCIT

PCTT is computed by dividing the correct target responses by the total number of possible target responses for the respective level of the task. 
RTT is the average response time for correct targets for all levels of the task.
PCIT is computed by dividing the total number of correct inhibitory trials by the total number of potential inhibitory trials for Levels 2 and 3, respectively.

General structure of the task:
Introduction -> First Rule and Practice -> Level 1 trials -> Second Rule and Practice -> Level 2 trials -> Third Rule and Practice -> Level 3 trials -> Feedback

# Usage example and instruction. How to run it?
You should specify subject number and just type run(subjectNumber). Tested with Matlab R2023b and Psychtoolbox 3.0.19.

TODO: improve randomization to make it quicker

# References
Main papers introducing the PGNG task and it's psychometric properties:
* [Langenecker, S. A., Zubieta, J. K., Young, E. A., Akil, H., & Nielson, K. A. (2007). A task to manipulate attentional load, set-shifting, and inhibitory control: Convergent validity and test–retest reliability of the Parametric Go/No-Go Test. Journal of clinical and experimental neuropsychology, 29(8), 842-853.](https://doi.org/10.1080/13803390601147611)
* [Votruba, K. L., & Langenecker, S. A. (2013). Factor structure, construct validity, and age-and education-based normative data for the Parametric Go/No-Go Test. Journal of clinical and experimental neuropsychology, 35(2), 132-146.](https://doi.org/10.1080/13803395.2012.758239)
* [One implementation of the task](https://www.millisecond.com/download/library/v6/pgng/pgng/pgng.manual)
* [Another description of the PGNG task](https://jankawis.github.io/battery_of_tasks_WIS_UCLA/PGNG.html)

Examples of usage:
* [Weidacker, K., Whiteford, S., Boy, F., & Johnston, S. J. (2017). Response inhibition in the parametric go/no-go task and its relation to impulsivity and subclinical psychopathy. Quarterly journal of experimental psychology, 70(3), 473-487.](https://doi.org/10.1080/17470218.2015.1135350) - mean PCIT over levels 2 and 3 correlates with Barratt Impulsivity Scale (BIS–11) Cognitive Complexity subscale and Blame Externalization subscale of the PPI–R
* [Langenecker, S. A., Jenkins, L. M., Stange, J. P., Chang, Y. S., DelDonno, S. R., Bessette, K. L., ... & Jacobs, R. H. (2018). Cognitive control neuroimaging measures differentiate between those with and without future recurrence of depression. Neuroimage Clin 20: 1001–1009.](https://doi.org/10.1016/j.nicl.2018.10.004) - the Parametric Go/No-Go Test elicited robust activation within networks known to be important for both error detection and Cognitive Control 
* [Michałowski, J. M., Wiwatowska, E., & Weymar, M. (2020). Brain potentials reveal reduced attention and error-processing during a monetary Go/No-Go task in procrastination. Scientific Reports, 10(1), 19678.](https://doi.org/10.1038/s41598-020-75311-2) - PGNG, P300, and academic procrastination.
