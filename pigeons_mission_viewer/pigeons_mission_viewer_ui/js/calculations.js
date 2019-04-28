.pragma library


function calculateErrorColor(err)
{
    if(err >=0 && err <=3)
    {
        return "green";
    }else if(err > 3 && err <=6)
    {
        return "yellow";
    }else if(err > 6)
    {
        return "red";
    }
}

    function calculateError(theo, measured)
    {
        var error = Math.abs(theo - measured).toFixed(2);
        return error;
    }
