import {Component, Input, NgZone, OnInit} from '@angular/core';
import {OscarItem} from '../../../../../models/oscar/oscar-item';
import {ItemStoreService} from '../../../../../services/data/item-store.service';
import {MapService} from '../../../../../services/map/map.service';
import {OscarMinItem} from '../../../../../models/oscar/oscar-min-item';

@Component({
  selector: 'app-item-detail',
  templateUrl: './item-detail.component.html',
  styleUrls: ['./item-detail.component.sass']
})

export class ItemDetailComponent implements OnInit {
  @Input() oscarItem: OscarItem;
  @Input() parent: string;
  keyValues: object[] = [];
  constructor(private itemStore: ItemStoreService,
              private mapService: MapService) { }

  ngOnInit() {}
  panTo() {
    this.mapService.setView(this.oscarItem.bbox[0], this.oscarItem.bbox[2], 18);
  }

}
