use Device::MiniLED;

my $sign = Device::MiniLED->new(devicetype => "sign");
my $height = $ARGV[0];
my $width = $ARGV[1];
my $data = $ARGV[2];

my $pic = $sign->addPix(height => $height, width => $width, data => $data);
$sign->addMsg(data => $pic, effect => "scroll", speed => 1);
$sign->send(device => "/dev/ttyUSB0");