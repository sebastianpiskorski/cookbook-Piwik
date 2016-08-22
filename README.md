# piwik-cookbook

Setup Piwik with MariaDB + Nginx

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['piwik']['user']</tt></td>
    <td>String</td>
    <td>Unix owner of project</td>
    <td><tt>vagrant</tt></td>
  </tr>
</table>

## Usage

### piwik::default

Include `piwik` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[piwik::default]"
  ]
}
```

## License and Authors

Author:: Kamil Zajac (kaz231@outlook.com)
