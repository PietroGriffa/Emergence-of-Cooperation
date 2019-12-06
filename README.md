##  Agent-Based Modeling and Social System Simulation - Fall 2019

#  Emergence of Cooperation with Stationary Leaders

> * Group Name: cooperETHors
> * Group participants names: Griffa Pietro,  Hunhevicz Jens, Kerstan Sophie, Stolle Jonas
> * Project Title: Emergence of Cooperation with Stationary Leaders

## General Introduction

The statements that our species’ evolutionary success can be attributed largely to the abil-ity and willingness to cooperate and that this is one of the most puzzling mechanisms inhuman  and  natural  systems  are  definite.  Examples of voluntary cooperation arenumerous and include resource sharing across international borders despite the absence ofa central authority or interorganizational knowledge exchange by firms to gain competitive advantage. However, cooperation is a many-faceted phenomenon and from an evolutionary game theory perspective not as self-evident as our everyday experiences and the long list of conceivablereal-world  examples  may  suggest. Due to the mismatch between this theorization and real-world occurrences, research has investigated mechanisms that enable the outburst, spread and preservation of cooperative behavior.  Despite these efforts, the nature of cooperation is not yet fully understood. Partly, this is because the number of potentially discussable parameters is vast.  As a result, there is still room to experiment with existing findingsand examine the impact of certain single factors as well as their combinatory effects.

First, an important aspect has been found to by imitation of the successful behaviour of others. Second, mobility is a key part of migration. Helbing et al. [1] shows in their agent based model simulation that the combination of imitation and success-driven migration can lead to clusters of cooperation, where on their own these two strategies mostly fail to maintain cooperation.

While imitation and migration have been widely recognized as mechanism, the specific construct and potential relevance of leadership has been added to the discussion more recently. Leaders can be seen as role models, showing exemplary behavior, which might eventually be copied by followers. While some studies on leadership exist (e.g Bahbouhi et al. [2]), no sources that coupled imitation and success-driven migration with leadership behaviour was found. This model studies the model of Helbing et. al [1] in combination with leadership behaviour. Exemplary real world cases would be e.g geographic places that attract talent and create hubs of cooperation, e.g. the Silicon Valley.

## The Model

The goal is to study the emergence of cooperation, extending the agent based model of Helbing et al. [1] towards stationary leadership [2]. The repeated interactions are studied on a spatial grid. Agent based modelling has been successful in studying general behaviour of cooperation such as imitation and success-driven migration. Using a spatial grid, the interactions can be visualized. More information on the used parameters and the exact setup of the model can be found in the [report](doc/report_cooperETHors.pdf). The underlying game theoretical mechnism is the Prisonner's Dilemma game. Even though the Nash equilibrium in this game is mutual defection, the simulations show that additional mechnisms such as imitation coupled with success-driven migration maintain and even increase cooperation. Adding leadership behaviour, the effects on cooperation can be studied also from this perspective. The simulation was implemented with Matlab. The code and [README](code/README.md) that describes how to reproduce the results can be found in the `code` folder.

## Fundamental Questions

The overarching goal of this project is to study the factors that contribute to the emergence of cooperation by developing and testing an agent-based model based on game theoretical tenets.  More precisely, the following sub-goals constitute the basis of the projectand report:
1.  Replication of the core parts of the model of Helbing et al. [1] and findings on the persistence and emergence of cooperation due to the combinatory effect of unconditional imitation and success-driven migration.
2.  Extension  of  said  model  by  the  concept  of  stationary  leadership  by  example  with inclusion  of  punishment  and  reward,  referring  to Bahbouhi et al. [2].

Summarized, the main question is:
* Can we model effects of leadership in an agent based model together with imitation and success-driven migration to show effects of emerging cooperative clusters in stationary places around leaders (e.g the Silicon Valley case)?

## Expected Results
We  argue  that  leadership  is  not  only  a  relevant  mechanism to cooperation as outlined above, but further has the potential to explain where and why clusters of cooperators emerge.  Our hypothesis therefore is, that the pattern of emergence of cooperators will be contingent on the positions of leaders on a two-dimensional grid.



## References

The work is mainly based on the following two references. In the [report](../doc/report_cooperETHors.pdf) (see folder `doc`), additional literature is reviewed and discussed.

[1]  Dirk Helbing, Wenjian Yu, and Heiko Rauhut. Self-organization and emergence insocial systems:  Modeling the coevolution of social environments and cooperativebehavior.Journal of Mathematical Sociology, 35(1-3):177–208, 2011.

[2]  Jalal  Eddine  Bahbouhi  and  Najem  Moussa.   A  graph-based  model  for  publicgoods with leaderships.Applied Mathematics and Computation, 349:53–61, 2019.

## Research Methods

This reserach is using Agent-Based Simulation to study the emergence of cooperation on a spatial grid. The underlying game theory mechanism is based on the Prisoners Dilemma. In addition to the standard interaction in their "Von-Neumann neighborhood" - imitation, success-driven migration, and leadership is introduced. For more detailed information please see the [report](../doc/report_cooperETHors.pdf) (see folder `doc`). The results of the simulation will be dicsussed and interpreted.

## Reproducibility of the Model

Please see the [README](../code/README.md) in the `code` folder for further instructions.
