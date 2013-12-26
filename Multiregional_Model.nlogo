 extensions [ numanal stats pathdir shell time table profiler string]

__includes [
  
  "Globals and Breeds.nls" 
  "Model Setup.nls" 
;  "Industry Setups.nls" 
  "Policy Procedures.nls" 
  
  
  "Populate with Firms.nls"
  "Model Go.nls" 
  
  "Firm Procedures.nls"
  "Price Conversions.nls"
  "Cost Procedures.nls"
  "Cost Procedures - CES.nls"
  "Cost Procedures - CD.nls"
  "Market Clear.nls"
  "Profit Procedures.nls"
  
  "Display Procedures.nls" 
  "File Procedures.nls"
  
  "SolutionMethods.nls"
  "Utilities-v12.nls" 
  
]

;; ------------------------------------------------------------------------------------------------------
@#$#@#$#@
GRAPHICS-WINDOW
222
10
607
416
2
2
75.0
1
11
1
1
1
0
0
0
1
-2
2
-2
2
1
1
1
Period
30.0

BUTTON
5
10
97
43
New World
button-world-new
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1145
465
1217
498
Run For
ifelse gbl.setup-stable? [\n  let toss run-for gbl.halt-period false\n]\n[\n  output-print \"No stable setup from which to begin.\"\n]\nstop
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
615
11
975
161
Number of Suppliers to Each Market
NIL
NIL
0.0
20.0
0.0
20.0
true
true
"" ""
PENS
"ruler" 1.0 0 -1513240 false "" ""

PLOT
979
10
1345
161
Exports
NIL
NIL
0.0
20.0
0.0
150.0
true
true
"" ""
PENS
"ruler" 1.0 0 -1513240 false "" ""

PLOT
615
470
982
619
Imports
NIL
NIL
0.0
20.0
0.0
150.0
true
true
"" ""
PENS
"ruler" 1.0 0 -1513240 false "" ""

PLOT
615
315
979
465
Pbar
NIL
NIL
0.0
20.0
50.0
150.0
true
true
"" ""
PENS
"ruler" 1.0 0 -1513240 false "" ""

INPUTBOX
150
50
210
120
gbl.Seed
55555
1
0
Number

PLOT
981
163
1345
313
Average Profit of Firms in
NIL
NIL
0.0
20.0
0.0
5.0
true
true
"" ""
PENS
"ruler" 1.0 0 -1513240 false "" ""

INPUTBOX
1145
505
1220
565
gbl.halt-period
3
1
0
Number

OUTPUT
5
465
610
665
14

PLOT
981
312
1345
460
Average A of Producing Firms in
NIL
NIL
0.0
20.0
0.75
1.25
true
true
"" ""
PENS
"ruler" 1.0 0 -1513240 false "" ""

SWITCH
5
49
140
82
gbl.save-setup?
gbl.save-setup?
1
1
-1000

BUTTON
107
11
211
44
Import World
button-world-import
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
1350
290
1495
323
gbl.allow-new-firms?
gbl.allow-new-firms?
0
1
-1000

SWITCH
1225
505
1372
538
gbl.write-to-file?
gbl.write-to-file?
1
1
-1000

SWITCH
5
430
105
463
gbl.profile?
gbl.profile?
1
1
-1000

INPUTBOX
1350
325
1490
385
gbl.initial-cash-balance
500
1
0
Number

CHOOSER
1350
385
1488
430
gbl.loss-criterion
gbl.loss-criterion
"profits" "cash-balance"
1

CHOOSER
5
125
147
170
gbl.solution-method
gbl.solution-method
"Simplex" "Simplex-NM" "Simplex-MD" "BOBYQA-minimize" "CGS-minimize" "CDS-minimize" "CMAES-minimize"
1

MONITOR
1000
515
1057
560
Steel TC
[ind.transport-cost] of i-w-n \"steel\"
2
1
11

MONITOR
1065
515
1122
560
Auto TC
[ind.transport-cost] of i-w-n \"autos\"
17
1
11

CHOOSER
1000
465
1092
510
gbl.plot
gbl.plot
"autos" "steel" "none"
0

TEXTBOX
370
420
440
438
firms/suppliers
11
0.0
1

SLIDER
1350
10
1485
43
gbl.max-new-markets
gbl.max-new-markets
0
4
1
1
1
NIL
HORIZONTAL

INPUTBOX
5
215
150
275
gbl.policy-data
policy-data-tc50.csv
1
0
String

SWITCH
5
395
140
428
gbl.look-at-setup?
gbl.look-at-setup?
0
1
-1000

PLOT
615
165
975
315
Number of Producers in Each Locality
NIL
NIL
0.0
20.0
0.0
20.0
true
true
"" ""
PENS
"ruler" 1.0 0 -1513240 false "" ""

SWITCH
5
360
165
393
gbl.write-setup-to-file?
gbl.write-setup-to-file?
1
1
-1000

SWITCH
1225
540
1375
573
gbl.messages-to-file?
gbl.messages-to-file?
1
1
-1000

MONITOR
995
565
1062
610
Steel FMe
[ind.follow-me] of i-w-n \"steel\"
2
1
11

MONITOR
1065
565
1127
610
Auto FMe
[ind.follow-me] of i-w-n \"autos\"
2
1
11

@#$#@#$#@
## WHAT IS IT?

V11 includes a number of changes, including much reworked coding, using a hacked extension for scheduling, using csv files for data input, etc.  With v11.10 we've moved to using git and GitHub for version control. 2013-12-11

V10 is a fresh start in April 2013.  (V8 was last worked on in August 2012.)  V10.00.00 includes our own NL scheduler routines, added to utilitesV7.nls to form utilitiesv8.nls.

In V8.00.06 we move from an explicit limit on shipments to a "cost function" that penalizes larger changes in sales.  This will be reflected in the expected price when shipments are being set, and then in the actual price received by the firm when those shipments are sold.  This is all part and prelude to having entry costs into export markets.

V8.00.03 - versions 00, 01, 02 and finally 03 were all attempts at first beginning from the start with heterogeneous firms (in terms of their technological constants, A), and thus having the average of firm profits be greater than zero, since only the more productive firms survive.  In V8.00.03 we finally got setup working properly.  In the process we did a lot of cleaning up of code and procedures throughout the model, all of which will hopefully bear fruit in the next stage of iterating the model through time and policy changes. So, the next step in .04 will be to move to the interation through time.  In the process, we will use a new event scheduling extension to keep track of policy and other changes. (In the end, we wrote in V10.00.00 a simplified event scheduler of our own in NL itself. The dynamic-scheduler extension was not designed for our purposes.)

V7.13.10 - We added to the turtle hierarchy by having a "world" turtle that holds the industry and patch lists rather than having those lists be globals.  Only variables that are truly control variables for a series of runs should now be globals.  We also cleaned up a lot of things in the process and prepared the model for running BehaviorSpace in "headless" mode.

V7.13.00 - We have finally finished the change to the direct maximization of profit.  We have also introduced expected profits on shipments and acutal (called "current") profits on sales.  Entry and exit is based on the latter.  As a test, we also calculate MR in each market and spot tests of these values against each other and against SRMC suggests that equality holds, as it should.  (See the question in "Extending the Model" about whether we should move to a different criterion for entry and exit.)

V7.12.15 - We have modeled interdependence by having each firm assume that all other firms will match x% of the firm's change in shipments to the given market.  x is a global variable, gbl.follow-me, and is set using a slider on the interface.  It may be positive or negative, although positive seems the most likely.  A value of 33% keeps things pretty stable.  We have also introduced an expected netprice, the price at which the firm expects to sell its goods when it is making its decision about how much to produce.  Like the actual price, the expected price is determined by calculating the price at which the given volume can be sold in the market, given too what other firms have, or are expected to ship.

V7.12.00 - In the move to version 12, we've replaced the MR = MC method of maximizing profits using a multivariate zeroin, with a direct maximization of profits using a multivariate simplex method. Direct maximization is said by the literature (e.g., Numerical Recipes) to be more robust than finding the zero.  (Indeed, given our experience of non-convergence of the zeroin routine with certain model parameters, this is not surprising.) It will, however, require thinking about how to take into account interdependent pricing behavior, which previously was reflected in the marginal revenue calculation.

V7.11.6 - Well, all that proved to be messier than we hoped!  The limits to changes in firm shipments to any given market have been implemented.  We have also reintroduced the pruning and creation of firms based on firm profits and regional profits, respecitively.  A number of aspects of the code have been cleaned up as well.  We have not, however, introduced the setting of firm shipments based on smoothed market prices (which in the current case would be smoothed Phats and P-tildas).  Firms do see current prices and it seems more reasonable to have them be cautious in changing their shipments rather than assuming that some average prices will be the norm.  On the other hand, all the necessary pieces are in place to implement this, in particular we keep histories of Pbar and Phat (but not yet P-tilda) in case we need them.  Indeed, a number of changes were made to the model in order to make the gathering of histories more transparent.

V7.10.8 - Instability in the markets as firms entered and withdrew on the basis of small changes in price led us to make two changes in firm behavior.  The first, implemented in V7.10.8, is to limit the change in the firm's shipments to any market in any period.  The idea here is that increasing sales significantly in a market takes some time and is not simply a matter of price.  Moreover firms may be risk averse in the sense that they will not want to put all their eggs in one basket, at least not too quickly.  For more or less the same reasons, firms will not withdraw too quickly from a market given the investment they have presumably made in selling there over time.  We can play around with the limits on the change in shipments to see how that will affect market stability.  At the moment, the maximum change is a proportion of the firm's total sales (frm.max-shipment-change), but it could instead be a proportion of the firm's sales to that market.

The second change is to have firms look not at the current mkt.Pbar in setting their desired level of sales, but rather at some moving average of the current and past Pbars in the market.  This will be done in V7.10.9.

Two other questions to look at: will making the industries less competitive (by lowering the parameter "b" in the demand curve facing the firm) increase stability, and will making the market demand curve more elastic or less elastic have a similar impact.  We will need to think about the latter, as well as simply trying it out.

V7.10 - As noted below, this version changes the market demand curve to use a weighted average price rather than a simple average price as its argument.  The weights are the shares of each active firm.  This, however, requires that the firms' prices be solved for differently since Pbar, and thus Ptilda, are not known in advance.  Before, the total amount to be sold determined Pbar for the market and the individual amounts to be sold determined the shares.  Since we knew both Pbar and the shares (which depend on Pbar and Ptilda), we could solve for the price of each firm that resulted in those shares.  Now the total amount to be sold determines Phat, not Pbar.  So, we need to solve for the firms' prices simultaneously such that they result both in the the shares that we are given (and thus the Pbar that yeilds those shares) and the Phat needed to clear the market.  Fortunately these are linear equations and we can use NetLogo's matrix extension to construct matrices for the simultaneous solution of the set of linear equations.

The solution seems to be relatively fast, at least for the small numbers of firms we are working with at this point.

V7.01 - This version works through the model setup.  We needed to pay attention to the value of "b" in the shares function as if it is too small, as some range of transport costs we get strange results with very high priced foreign firms dominating the market with a single low-price domestic firm.  Although we might expect some diversity, the fact that the high priced foreign firms lead to a high Pbar and small market demand, keeps the local firm from taking over much of the market in spite of its lower price.  In V7.10, we try a new market demand function that uses Phat rahter than Pbar, where Phat is a weighted average of the prices of the supplier, (weighted by each supplier's market share.  That solution is more complex.  See the note for V7.10.

V7.00 - This is a complete reworking of the model setup.  We use a different method to find the initial number of firms in each region that will set profits in each region approximately to zero.  That method essentially finds the combination of shipments from each region that set MR = MC for each firm in each region, uses those shipments to calculate the firms' profits, and then adds or substracts firms until those profits are approximately zero.  We've also cleaned up many of the procedures and consolodated others.  Still a work in progress!

V6.00 - This is an experiment looking at a quantity rather than a price adjustment model.  More details later!

V5.00 - We seem finally at the point where we can look at results!  I suspect in these next runs we will see a lot of volatility and we may in the next set of changes work on reducing that - or rather thinking about how real markets do that.  At the moment, firms set price but do not have a lot of control over the subsequent volume of shipments.  Smoothing shipments, or even production, may be where we need to go next.

V4.90 - This version is set up to introduce policy changes at a particular time (or times) in the simulation.  Hopeully this will put us in a position to actually begin modeling for real.  As of V4.94, the criterion for the inner loop in the populate-by-industry procedure moved from a comparison of prices to a comparison of actual vs. intended sales in each market by each firm.  In V4.95, we set the market betas with a more explicit reference to competitiveness and the scale of prices.  See notes of November 18, 2009 for the background on this.  In the process of doing this it was revealed that the inner loop of populate-industry-with-firms could cycle wildly, without a decernable pattern, at certain combinations of mkt.beta and the number of suppliers.  We took a very ad hoc approach to solving this problem.  We'll perhaps need to deal with this in a more sophisticated way, anon.

V4.80 is a continuation of V4.7x.  It took many sub-versions to get it to work!  Interesting results as transport costs increase.

V4.70 - Another right angle!  We now initialize on the level of the industry rather than each producing region, by inserting firms in each region until profits are zero.  This allows us to initialize with transport costs and commercial policy already in place.  Because firms are discrete and enter with given capacities, profits will not be exactly equal to zero, but are as close as we can get without their being negative.  We set the profit tolerance slider accordingly.  We try to even out the firms among the regions if we can.  (Perhaps at some point we could adjust the initial capacities to get profits closer to zero using some kind of iterative technique once the regions are populated.)  Note that we also distiguish between the intended sales of firms and their actual sales.  If intended sales are zero, we assume that firms will not sell at all and set their actual sales accordingly.  We need to do this because when they set the price they think will result in zero sales, it may not given the prices of other firms.  But whereas firms actively in the market are committed to the price they've set, firms with no intention of being in the market are not.  (Note that we can't just have the firm set a very high price as this messes up the marginal revenue calculations.)

V4.60 - Before completely finishing V4.5x, the problems arising from the constant elasticity demand function for dS/dPbar reemerged in the mathematics of the dq/dPi, particularly its behavior as q --> 0. So we took this opportunity to change the demand structure. We retain q = S(1/n - (Pi - Ptilda)), but instead of S = S0*Pbar^eta we move to Pbar = P0 - aS^sigma, where sigma < 1. The demand curve therefore has both P and S intercepts and its elasticity --> 0 as P --> 0, and --> -infinity as S --> 0. Thus we don't have a problem with MR being zero or negative when the market becomes monopolistic. We also further partition our demand procedures to separate dS/dPbar so that we can change this element of demand independently from the impact of a firm's price on its market share.

In V4.50, we put the firms at the tangency between the demand curves they face and their SRATC curves, rather than at min SRATC as in V4.4x, setting the initial capital stock to make that happen. We begin with a desired number of firms and a market size, which then yields the market share of each firm and the output at which we want the above tangency to occur. This should give us zero profits and no incentive to change price in autarky. It will, however, lead to firms wanting to reduce K since capacity will be greater than q, and if we allow it, we will get the phenominon of more ever smaller firms over time. We can try that to see if it happens!

In V4.40 we change entirely the way we initialize the firms in each region.  We go back to a more explicit solution for the number of firms and the initial price and then create the firms en masse.  So we calculate LTATC for firmst in the industry given their initial, identical production functions and factor prices.  Then we set each firm's capacity to its share of the market, given the number of firms we want.  By starting each firm at capacity and the industry price at LRACT, firms start with zero profits, at the bottom of their SRATC curvess (assiming CRS).  However, this is not a short-run equilibrium for the firm since it can raise price and earn profit.  (The demand curve is cutting through the SRATC curve.)  So, the industry quickly moves toward a higher price and profits, and attracts entry.

Note that V4.3x never got beyond the initialization problems this new version is designed to solve.

In V4.30 we change the Marginal Revenue calculation to recognize that although the prices of other firms are assumed fixed by the firm, it knows that its own price will affect the average price and therefore the size of the market.  The effect may not be trivial when the number of firms is small.  Moreover, the firm's own price should not be included in the average price of other firms that sets the firm's market share. 

In V4.10 we allow a move from the short run to the long run by allowing the firm to adjust its capital stock over time.  This will no doubt raise a lot of questions in the process!

With V4 we have moved to a Cobb-Douglas production function and therefore (unless beta = 1) increasing marginal cost.  We also can now have CRS or IRS depending upon the sum of alpha + beta.  This involves the addtion of some new firm variables and the retargeting of external economies from influencing marginal cost to (in the initial case) influencing the technological constant in the production function.  (We could think about its influencing the productivity of labor alone.)

In V3.7x we have changed the naming convention for global and breed variables, and we have cleaned up and more fully documented the code.  V3.xx is likely the last version to retain the simple cost function.  We also changed model-setup to use the maximize-profit procedure so that the particular cost and demand functions can be further segregated into just the demand and cost procedures.  It is a bit slower, but setup happens only once!

With V3.60 we changed the way in which firms set outputs.  Now firms in each region set their outputs in each market by equating MR in each market with the common MC.  This allows marginal cost to be a functon of total output with no particuar functional forms for MC and MR assumed.  (They do need to be specified however!)  The assumption is that all tariffs, subsidies and transport costs are reflected in the MR the firm receives in each market, allowing MC to be the same for all markets.  We use a primitive hill-climb algorithm that maximizes profits using the information on slopes provided by the MC and MR functions.  At some point we will want to find a more speedy and robust procedure.

We still have constant marginal costs where total cost is of the form:

TC = FC + MC*q

External economies are dependent upon the number of firms in the producing region, with two alternative response functions, one exponential and one quasi-exponential.  

This version can handle multiple industries with heterogeneous firms, although there is no interaction among the industries.  It initializes itself with each region operating in autarky.  The model then responds to the parameters for transportation costs, tariffs and subsidies in allowing trade to take place among the regions.

V3.36 follows on in the spirit of V3.35 - more tweaks.

V3.0 follows on V2.74 but recasts the whole model in terms of trade links.  Firms create trade links to individual markets.  Markets are located on patches, as are firms.  Also allows for multiple industries - at this point with no interdependencies - in a relatively transparent way for coding.

Up through V2.7, constant adjustments - hopefully improvements - to the creation and death of firms.  Still no external economies.

V2.5 based entry and exit on expected profits rather than simply past profits, by forcasting next period's profit on the basis of past experience.

V2.4 improved initialization procedures to get the right number of firms in each market so that profits are (approximately) zero.  The number depends upon whether or not we are in aurtarky or free trade.

## HOW IT WORKS

This section could explain what rules the agents use to create the overall behavior of the model.

## HOW TO USE IT

This section could explain how to use the model, including a description of each of the items in the interface tab.

## THINGS TO NOTICE

This section could give some ideas of things for the user to notice while running the model.

## THINGS TO TRY

This section could give some ideas of things for the user to try to do (move sliders, switches, etc.) with the model.

## EXTENDING THE MODEL

Next steps (but not necessarily in this order):  
? (DONE) Do we need an expected profit?  One which takes into account the expected price and current shipments?  Given that costs depend on current production and revenues on past production, changes in output (and therefore price) can in the short run lead to large positive or negative profits.  Do we calculate expected profits on current shipments, or profits on current sales using the cost of production of those goods?  We should do one or the other!

? Introduce factor markets by allowing the labor wage in each region to be endogenous.  (Use the wage of capital as a numeraire.)

? Think through how to introduce changes in policy in a transparent way.

? Think through demand again, particularly with multiple industries that may have interdependent demands.  That presumably means going to some kind of utility function in all the industries and goods.  A homogenous good would have a very high "b"?

? We want to have firms in some regions that produce capital intensively and in other that produce labor intensively.  Clearly the production function allows that, but how do we best set that up?  With different wages in each region?  But then don't we have to have different prices of capital if the high wage country is not simply to be high cost?  Or will we simply get HOS specialization?  If we want intraindustry trade, then do we need different production functions in different regions, i.e., different alphas and betas?

? We have not introduced the setting of firm shipments based on smoothed market prices (which in the current case would be smoothed Phats and P-tildas).  Firms do see current prices and it seems more reasonable to have them be cautious in changing their shipments rather than assuming that some average prices will be the norm.  On the other hand, all the necessary pieces are in place to implement this, in particular we keep histories of Pbar and Phat (but not yet P-tilda) in case we need them.  Indeed, a number of changes were made to the model in order to make the gathering of histories more transparent.

? Allow firms to have nationality and to open plants abroad.  All sorts of issues here about relative efficiency, cost of K and L, production techniques, etc.

? Introduce and "agricultural" good?

? Will we ultimately need a B/P and exchange rate?

? Figure out why the gbl.follow-me value of +33% seems to generate the most stability in the market.  We know that the perfectly competitive solution with follow-me = 0% leads to a cobweb type behavior, as does a follow-me of +100%.  (We've done this in part.  Given the small number of firms there can be no notion of a competitive market so a follow-me of zero does not equate with competitive behavior - the firm still affects the market price.)

? We now have very small shipments at (presumably) very high prices.  This artificially inflates the number of suppliers.  We should consider having a minimum shipment (e.g. as low as one?) to prevent this from happening.  On the other hand, might this happen in reality? Would the minimum be some proportion of total shipments?  One issue here is that this "inflates" the number of suppliers to the market, but I'm not sure if that makes any substantive difference.  It would be relatively easy to have a globally-set minimum shipment - that could be set to zero.

? In setup, there are times when no configuration in the cycle that ends populate-with-firms has all non-negative profits.  In that case we simply choose the one with the minimum sum of squared profits.  But, should we backup to the portion of profit history that contains configurations that have all non-negative profits and choose one of those?

? Should we use a different criterion for entry and exit?  E.g., with our new expected and current profit measures, we could also have a cash-flow/cash-balance measure that might be useful for both entry/exit and expansion/contraction.

? Put a datastore for each industry in every region, but allow some to me marked as "inactive".  This will make it easier to start up production in a region that previously had no firms.

? In setup-maximize-profits, should we use a minimum percentage difference in shipments rather than a minimum absolute difference?  Both have their virtues.

? Need to fix gbl.profit-tolerance monitor as it is now a world variable.

## NETLOGO FEATURES

This section could point out any especially interesting or unusual features of NetLogo that the model makes use of, particularly in the Procedures tab.  It might also point out places where workarounds were needed because of missing features.

## RELATED MODELS

This section could give the names of models in the NetLogo Models Library or elsewhere which are of related interest.

## CREDITS AND REFERENCES

This section could contain a reference to the model's URL on the web if it has one, as well as any other necessary credits or references.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

car side
false
0
Polygon -7500403 true true 19 147 11 125 16 105 63 105 99 79 155 79 180 105 243 111 266 129 253 149
Circle -16777216 true false 43 123 42
Circle -16777216 true false 194 124 42
Polygon -16777216 true false 101 87 73 108 171 108 151 87
Line -8630108 false 121 82 120 108
Polygon -1 true false 242 121 248 128 266 129 247 115
Rectangle -16777216 true false 12 131 28 143

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sailboat side
false
0
Line -16777216 false 0 240 120 210
Polygon -7500403 true true 0 239 270 254 270 269 240 284 225 299 60 299 15 254
Polygon -1 true false 15 240 30 195 75 120 105 90 105 225
Polygon -1 true false 135 75 165 180 150 240 255 240 285 225 255 150 210 105
Line -16777216 false 105 90 120 60
Line -16777216 false 120 45 120 240
Line -16777216 false 150 240 120 240
Line -16777216 false 135 75 120 60
Polygon -7500403 true true 120 60 75 45 120 30
Polygon -16777216 false false 105 90 75 120 30 195 15 240 105 225
Polygon -16777216 false false 135 75 165 180 150 240 255 240 285 225 255 150 210 105
Polygon -16777216 false false 0 239 60 299 225 299 240 284 270 269 270 254

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.0.5
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

curved
0.4
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
1
@#$#@#$#@
