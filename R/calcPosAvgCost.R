#' Calculates the average cost of a resulting position from a transaction
#' 
#' @return PosAvgCost: average cost of the resulting position
#' @param PrevPosQty quantity of the previous position
#' @param PrevPosAvgCost average position cost of the previous position
#' @param TxnValue total value of the transaction, including fees
#' @param PosQty total units (shares) of the resulting position
#' @param ConMult multiplier from instrument data
#' @useDynLib blotter
#' @rdname calcPosAvgCost
.calcPosAvgCost <- function(PrevPosQty, PrevPosAvgCost, TxnValue, PosQty, ConMult=1)
{ # @author Peter Carl
    if(PosQty == 0)
        PosAvgCost = 0
    else if(abs(PrevPosQty) > abs(PosQty)){
        # position is decreasing, pos avg cost for the open position remains the same
        PosAvgCost = PrevPosAvgCost   
    } else {
        PosAvgCost = (PrevPosQty * PrevPosAvgCost * ConMult + TxnValue)/(PosQty*ConMult)
    }
    return(PosAvgCost)
}

.calcPosAvgCost_C <- function(PrevPosQty, PrevPosAvgCost, TxnValue, PosQty, ConMult=1)
    .Call("calcPosAvgCost", PrevPosQty, PrevPosAvgCost, TxnValue, PosQty, ConMult, PACKAGE="blotter")

###############################################################################
# Blotter: Tools for transaction-oriented trading systems development
# for R (see http://r-project.org/) 
# Copyright (c) 2008-2015 Peter Carl and Brian G. Peterson
#
# This library is distributed under the terms of the GNU Public License (GPL)
# for full details see the file COPYING
#
# $Id: calcPosAvgCost.R 1666 2015-01-07 13:26:09Z braverock $
#
###############################################################################
