define("INVITE_FILE","/tmp/lastinvite.dat");
define("INVITE_STALE",4500); //seconds
define("BOT_TOKEN","{vpDp-vlWMpedGATPceae84_mPkg-P4fh-iiWX6sXYk6eNyr-Zdld5bsDCZm-IqVgAkyv}");
define("CHANNEL_ID","{972507075932479488}");
function invite_discord($options)
{
//prevent too many messages
$f=file_exists(INVITE_FILE);
if ($f == false) $last=time()-500000;
else $last=@filemtime(INVITE_FILE);
$now=time();
$el=$now - $last;
if ($el < INVITE_STALE)
 {
 return file_get_contents(INVITE_FILE);

} // not last invite
// Replace the URL with your own webhook url
$url = "https://discordapp.com/api/v6/channels/" . CHANNEL_ID . "/invites";

$inviteobj=json_encode($options, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE );
$ch = curl_init();
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER,
     array( "Authorization: Bot " . BOT_TOKEN,
            'Content-Type: application/json',
            'Referer: https://discordapp.com/channels/@me'
));

 curl_setopt_array( $ch, [
    CURLOPT_URL => $url,
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => $inviteobj]);


$response = curl_exec( $ch );
$works=strpos($response,'{"code":' );
if ($works === false) return "";
file_put_contents(INVITE_FILE,$response);
curl_close( $ch );
return $response;
}
