# c229/e115电子手册
1.4.5版本(2020.09.25)
集成方法
c229:
ElectronicManualViewController *vc = [[ElectronicManualViewController alloc] init];
vc.modalPresentationStyle = 0;
vc.carID = @"C229";
[self presentViewController:vc animated:NO completion:nil];

e115:
ElectronicManualViewController *vc = [[ElectronicManualViewController alloc] init];
vc.modalPresentationStyle = 0;
vc.carID = @"E115";
[self presentViewController:vc animated:NO completion:nil];

