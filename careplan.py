import webbrowser
patients = ["B9307B32","37FFD518","EBDC2559","AB5F62F4","681B9887","681B9887"]
careplanStart = "https://hcac.healthmetrics.com.au/main.php?module=carePlan&customerCode="
carePlanEnd = "&action=bulkEdit&active=&active=1"
for patient in patients:
    webbrowser.open(careplanStart+patient+carePlanEnd)