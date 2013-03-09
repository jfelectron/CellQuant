function removeBurst(qcell,channel,burstid)

  
  fishobj=qcell.qobjs{channel};
  fishobj.removeBurst(burstid);
  qcell.burstdata{channel}=qcell.qobjs{channel}.getBurstData();
  qcell.bursts{channel}=qcell.qobjs{channel}.getImage({'burst_relabeled'});

     