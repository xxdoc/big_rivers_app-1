﻿dbMemo "SQL" ="PARAMETERS eventyr Long;\015\012SELECT w.ID, w.Label AS SubstrateClass, w.Code, "
    "w.DiameterRange_mm AS [Size], w.ActiveYear, w.RetireYear, w.Label + ' ('+ w.Code"
    " +')' AS category\015\012FROM ModWentworthScale AS w\015\012WHERE (\015\012(w.Ac"
    "tiveYear = [eventyr]) \015\012OR\015\012(w.RetireYear = [eventyr])\015\012OR\015"
    "\012(w.ActiveYear <[eventyr]) \015\012AND \015\012((w.RetireYear IS NULL) OR ([e"
    "ventyr] < w.RetireYear))\015\012)\015\012ORDER BY w.CategoryOrder;\015\012"
dbMemo "Connect" =""
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBinary "GUID" = Begin
    0xd0adfdbe4d7a184da5399778863d2cc8
End
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
Begin
End
